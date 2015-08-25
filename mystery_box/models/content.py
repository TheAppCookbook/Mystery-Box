from embedly import Embedly
import parse_rest.connection

from parse_rest.installation import Push as ParsePush
from parse_rest.datatypes import Object as ParseObject


class Content(ParseObject):
    # Class Properties
    _embedly_client = Embedly("74388f950f1d4a4f965cd185bfff2df3")
    _parse_client = parse_rest.connection.register(
        "OLjnAy2bGdU2J1AcQ118Ay5MV20ekLPqCb8U299K",
        "9rTz13ih8HEXNqnzT5jvBR0ExfkFNSl3kJA2J7G8"
    )

    # Initializers
    def __init__(self, source_url):
        ParseObject.__init__(self)
    
        obj = Content._embedly_client.oembed(source_url)
        
        self.object_description = obj['description'] if 'description' in obj else None
        self.title = obj['title'] if 'title' in obj else None
        self.url = source_url
        self.thumbnail_url = obj['thumbnail_url'] if 'thumbnail_url' in obj else None
        self.provider_name = obj['provider_name'] if 'provider_name' in obj else None
        self.type = obj['type'] if 'type' in obj else 'unknown'

    # Push Handlers
    def push(self):
        message = "Your next Mystery Box is ready to be opened!"
        ParsePush.message(message, channels=["all"])
