# Today

Daily outlines for [Turing School](http://turing.io).

Hosted [here](http://today.turing.io/).

## Working on this repository

Assuming you have Ruby set up, here are some things you can do:

```sh
git clone https://github.com/turingschool/today.git  # get the code locally
cd today                                             # cd into the code
bundle install                                       # install ruby dependencies (you'll need to be on Ruby 2.1.2)
bundle exec rspec                                    # I made a couple of tests for a helper class, see them run
bundle exec middleman server                         # Run a server for the pages, it does an okay job of dynamically reloading code
open http://localhost:4567                           # Visit the site you're serving
bundle exec middleman build                          # Build the pages
```

The site uses:

* Middleman to compile all the pages into a static website.
  You don't need to know too much about how it works, or at the very least, I'm
  pretty ignorant about it, but have been able to make quite a few changes.
  Links: [getting started](http://middlemanapp.com/basics/getting-started/) 
* Sass for stylesheets, links: [guide](http://sass-lang.com/guide), [docs](http://sass-lang.com/documentation/).
* Haml for content, links: [tutorial](http://haml.info/tutorial.html) , [docs](http://haml.info/docs.html).
