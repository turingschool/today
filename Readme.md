# Today

Daily outlines/schedules for the [Turing School of Software &amp; Design](http://turing.io) courses. These are used in combination with [lesson plans](https://github.com/turingschool/lesson_plans)
and often reference [JumpstartLab tutorials](http://tutorials.jumpstartlab.com).

The live version of these outlines is up at  [today.turing.io](http://today.turing.io/).

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

## License

Unless otherwise noted, all materials licensed <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-NonCommercial-ShareAlike 3.0</a>&nbsp;<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-sa/3.0/80x15.png" /></a>
