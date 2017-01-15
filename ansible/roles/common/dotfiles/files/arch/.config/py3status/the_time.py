# -*- coding: utf-8 -*-
import time;

class Py3status:

    def the_time(self):
        return {
            'full_text': time.strftime("%-l:%M %#p"),
            'cached_until': self.py3.time_in(1),
        }
