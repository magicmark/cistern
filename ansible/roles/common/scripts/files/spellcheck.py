#!/usr/bin/python
import sys
import urllib2
import xml.etree.ElementTree as ElementTree

def main(argv):
    url = 'http://service.afterthedeadline.com/checkDocument?data='
    url += argv[0]
    response = urllib2.urlopen(url).read()

    xml = ElementTree.fromstring(response)
    print(xml[0][3][0].text)

if __name__ == "__main__":
    try:
        main(sys.argv[1:])
    except:
        pass
