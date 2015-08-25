#! /usr/bin/env python

from models.source import Source
from models.content import Content
import random


# Main
if __name__ == "__main__":
    source = Source()
    content = Content(source.url)
    content.save()

    content.push()