#!/bin/sh

TAG=1.0

jazzy \
--clean \
--author "Petr Mánek" \
--author_url http://petrmanek.cz \
--github_url https://github.com/petrmanek/Revolver \
--github-file-prefix https://github.com/petrmanek/Revolver/tree/$TAG \
--module-version $TAG \
--xcodebuild-arguments -scheme,Revolver \
--module Revolver \
--output Documentation
