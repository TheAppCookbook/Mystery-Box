#! /usr/bin/env python

from models.source import Source
from models.content import Content
import random


# Main
if __name__ == "__main__":
#    source = Source()
#    content = Content(source.url)
    content = Content("http://www.huffingtonpost.com/2015/08/20/yolo-joe-11-reasons-why-you-should-jump-in-already_n_8030182.html")
    content.save()

    content.push()