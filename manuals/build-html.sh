#!/bin/bash

for i in *.md; do cmark $i > generated-html/${i/.md}.html; done