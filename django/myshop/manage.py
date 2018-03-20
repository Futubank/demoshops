#!/usr/bin/env python3
import os
import sys

from django.core.management import execute_from_command_line

if __name__ == '__main__':
    sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'myshop.settings')
    execute_from_command_line(sys.argv)
