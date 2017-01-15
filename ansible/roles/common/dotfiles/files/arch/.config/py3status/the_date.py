# -*- coding: utf-8 -*-
import time;

class Py3status:

    def the_date(self):
        return {
            'full_text': time.strftime("%A %d %B, %Y"),
            'cached_until': self.py3.time_in(1),
        }
