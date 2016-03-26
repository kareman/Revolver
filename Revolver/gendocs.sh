#!/bin/sh

TAG=1.0

jazzy \
--clean \
--author "Petr Mánek" \
--github_url https://github.com/petrmanek/Revolver \
--author_url http://petrmanek.cz \
--github-file-prefix https://github.com/petrmanek/Revolver/tree/$TAG \
--module-version $TAG \
--swift-version 2.2 \
--xcodebuild-arguments -scheme,Revolver \
--module Revolver \
--output Documentation
