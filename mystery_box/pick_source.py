#! /usr/bin/env python

from models.source import Source
import random


# Main
if __name__ == "__main__":
    url = random.choice(Source.source_list)
    source = Source(url, choose_random=True)
    print(source.url)
