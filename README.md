# GapBammon

A two-player hotseat backgammon with a terminal interface.
A student project at Tartu University.

Uku Loskit  
Lauris Kruusamäe  
Mikk Pavelson  
Madis Pink  

## Installation

Installation requires a modern ruby (1.9.3) installation with both rubygems
and the bundler gem installed (gem install bundler).

Clone the repository:

	git clone git@github.com:madisp/gapbammon.git

Install dependencies:

	bundle install

Install the application as a gem

	bundle exec rake install

## Usage

After installing the gem `backgammon` should be on your path.

## Repository Structure

	bin/              # contains the executable ruby file
	docs/             # contains both the compiled and uncompiled documentation for the project
	gapbammon.gemspec # gem specification file
	Gemfile           # gem dependency list
	Gemfile.lock      # actual versions of gems in dependency
	lib/              # actual application source code
	LICENSE           # project license file
	Rakefile          # ruby makefile for the project
	README.md         # this file

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Course

Data Modeling  
University of Tartu  
Tartu 2012
