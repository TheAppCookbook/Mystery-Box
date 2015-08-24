from bs4 import BeautifulSoup as Soup
import requests
import random
from urlparse import urlparse


class Source:
    # Class Properties
    source_list = open('sources.list').read().split('\n')
    _user_agent = (
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 '
        '(KHTML, like Gecko) Version/8.0.6 Safari/600.6.3'
    )
    
    # Initializers
    def __init__(self, url, depth=5, choose_random=True):
        self.url = Source._traverse_tree(
            url, depth, choose_random
        )

    # Class Accessors
    @classmethod
    def _traverse_tree(cls, source_url, depth, rand):
        url_parts = urlparse(source_url)
        base_url = (
            url_parts.scheme + 
            '://' + 
            url_parts.netloc + 
            (url_parts.port if url_parts.port else '')
        )
        
        print(">> " + base_url)
    
        traversed_urls = []
        url = source_url
                
        for i in range(depth):
            resp = requests.get(
                url,
                headers={'User-Agent': Source._user_agent}
            )
            
            if resp.status_code != 200:
                i -= 1  # repeat cycle
                continue
                
            traversed_urls.append(url)
            
            content_type = resp.headers.get('Content-Type')
            if content_type.startswith('text/html'):
                soup = Soup(resp.text, 'html.parser')
                soup = cls._clean_soup(soup)
                
                links = [
                    cls._clean_link(link.get('href'), base_url) for link
                    in soup.find_all('a')
                    if cls._clean_link(link.get('href'), base_url)
                ]
                
            else: # leaf node
                break

            next_url = cls._choose_link(links, rand=rand)
            
            print("... " + str(next_url))
            if next_url:
                url = next_url
            
        return traversed_urls[-1]
    
    @classmethod
    def _clean_soup(cls, soup):
        for elem in soup.find_all(id="header") or []:
            elem.decompose()
            
        soup = Soup(str(soup), 'html.parser')
        for elem in soup.find_all(class_="header") or []:
            elem.decompose()
            
        soup = Soup(str(soup), 'html.parser')
        for elem in soup.find_all(id="footer") or []:
            elem.decompose()
            
        soup = Soup(str(soup), 'html.parser')
        for elem in soup.find_all(class_="footer") or []:
            elem.decompose()
        
        return Soup(str(soup), 'html.parser')
        
    @classmethod
    def _clean_link(cls, link, base_url):
        if base_url.endswith('/'):
            base_url = base_url[:-1]
    
        if not link:
            return None
            
        link = link.strip()
        if link.startswith('#'):
            return None
        elif link.startswith('/'):
            return base_url + link
        else:
            return link
            
    @classmethod
    def _choose_link(cls, links, rand=True):
        # Use this method to implement any weighting
        if not links:
            return None
        
        # Limit to 20 links in the middle of the page,
        # since they'll likely be the useful ones
        
        links_count = len(links)
        if links_count > 20:
            start_index = (links_count - 20) / 2
            end_index = start_index + 20
        else:
            start_index = 0
            end_index = links_count

        # Then weight by length.
        # The longer the link, the more interesting
        # the content.
        
        links = [
            (link, len(link)) for link
            in links[start_index:end_index]
        ]
        
        return cls._weighted_choice(links) if rand else links[0]
        
    @classmethod
    def _weighted_choice(cls, choices):
       total = sum(w for c, w in choices)
       r = random.uniform(0, total)
       upto = 0
       for c, w in choices:
          if upto + w > r:
             return c
          upto += w
       assert False, "Shouldn't get here"