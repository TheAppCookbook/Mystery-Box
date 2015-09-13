import sys; import os
sys.path.insert(0, os.path.abspath('..'))
from models.content import Content


content = Content("https://en.wikipedia.org/wiki/The_Royal_Opera")
content.push()