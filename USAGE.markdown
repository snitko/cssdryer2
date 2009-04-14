This is a copypaste of README from http://github.com/airblade/css_dryer

# CssDryer -- Eliminate Repetition In Your Stylesheets
## Introduction

Cascading style sheets (CSS) are wonderful but repetitive.  [Repetition is bad](http://en.wikipedia.org/wiki/Don't_repeat_yourself), so CssDryer lets you write CSS without repeating yourself.  And you don't need to learn any new syntax.

There are two sources of repetition in CSS:

* nested selectors
* lack of variables

Nested selectors lead to CSS like this:

    div           { font-family: Verdana; }
    div#content   { background-color: green; }
    div#content p { color: red; }

Note the triple repetition of `div` and the double repetition of `#content`.

The lack of variables leads to CSS like this:

    .sidebar { border: 1px solid #fefefe; }
    .content { color: #fefefe; }

Note the repeated colour `#fefefe`.

CssDryer eliminates both of these.  The examples above become:

    <% dark_grey = '#fefefe' %>

    div {
      font-family: Verdana;
      #content {
        background-color: green;
        p { color: red; }
      }
    }

    .sidebar { border: 1 px solid <%= dark_grey %>; }
    .content { color: <%= dark_grey %>; }

Note, though, that `@media` blocks are preserved.  For example:

    @media screen, projection {
      div {font-size:100%;}
    }

is left unchanged.

The original whitespace is preserved as much as possible.


## Which Selectors Are Supported?

CssDryer handles all [CSS 2.1 selectors](http://www.w3.org/TR/CSS21/selector.html): nested descendant, child, adjacent, class, pseudo-class, attribute and id selectors.

Multiple comma separated selectors are also supported.


## Comments

Comments on nested selectors do not get 'flattened' or de-nested with their selector.  For example comment B will be left inside the html selector below:

Before:

    /* Comment A */
    html {
      /* Comment B */
      p {
        color: blue;
      }
    }

After:

    /* Comment A */
    html {
      /* Comment B */
    }
    html p {
      color: blue;
    }

This is suboptimal but I hope not too inconvenient.

Please also note that commas in comments will sometimes be replaced with a space.  This is due to a shameful hack in the code that handles comma-separated selectors.


## Partials

You may use partial nested stylesheets as you would with normal templates.  For example, assuming your controller(s) set the @user variable and a User has a background colour (red):

app/views/stylesheets/site.css.ncss:

    body {
      color: blue;
      <%= render :partial => 'content', :locals => {:background => @user.background} %>
    }

app/views/stylesheets/_content.css.ncss:

    div#content {
      background: <%= background %>;
      margin: 10px;
    }

And all this would render to `site.css`:

    body {
      color: blue;
    }
    body div#content {
      background: red;
      margin: 10px;
    }


## Remember the helper

Browser hacks are an ugly necessity in any non-trivial stylesheet.  They clutter up your stylesheet without actually adding anything.  They make you sad.

So encapsulate them in the StylesheetsHelper instead.  Separate your lovely CSS from the decidely unlovely hacks.  For example:

app/views/stylesheets/site.css.ncss:

    <% ie7 do %>
      #sidebar {
        padding: 4px;
      }
    <% end %>

This renders to `site.css`:

    *+html #sidebar {
      padding: 4px;
    }

In this example the hacky selector, `*+html`, isn't too bad.  However some hacks are pretty long-winded, and soon you'll thank yourself for moving them out of your nested stylesheet.

You don't have to limit yourself to browser hacks.  Consider self-clearing: to make an element clear itself requires 13 lines of CSS, in 3 selector blocks, by my count.  To make a second element clear itself, you need to add the element's selector to each of those three blocks.  It's fiddly.  And your stylesheet gets harder and harder to understand.

We can do better:

    <%= self_clear 'div.foo', 'div.bar', 'baz' %>

Self-clear as many elements as you like in one easy line.

## Alternatives

* [RCSS][1]: ERB, server-side constants, server-side classes and command line execution.  No nesting as such, though server-side classes offer a form of inheritance.

* [DCSS][2] (written up [here][3]): server-side constants, different syntax.  Descendant selectors only.

* [Styleaby][4] creates CSS with Ruby syntax.  "An experimental, unauthorized mashup of Scott Barron's stillborn Builder::CSS templates and Why The Lucky Stiff's Markaby templates."

* [Dirt Simple .rcss Templates][5] by Josh Susser.  No nesting, just variables.

[1]: http://rubyforge.org/projects/rcss
[2]: http://rubyforge.org/projects/dcss
[3]: http://myles.id.au/2006/11/20/introducing-dcss/
[4]: http://topfunky.net/svn/plugins/styleaby/README
[5]: http://blog.hasmanythrough.com/2006/3/23/dirt-simple-rcss-templates


## Credits

The idea came from John Nunemaker on [Rails Tips][6].  John beta-tested the code, provided a test case for @media blocks and suggested the controller's body.  Thanks John!

The caching code is based on [Topfunky's][7].

Changing the controller's name to `stylesheets`, thus allowing one to use Rails' `stylesheet_link_tag` helper, occurred to me while reading Josh Susser's [Dirt Simple .rcss Templates][5].  Once I noticed it, I realised everybody was using a `StylesheetsController`.  Doh!

[6]: http://railstips.org/2006/12/7/styleaby-css-plugin/
[7]: http://topfunky.net/svn/plugins/styleaby/lib/stylesheets_controller.rb


## Author

[Andrew Stewart][8], [AirBlade Software Ltd][9].

[8]: mailto:boss@airbladesoftware.com
[9]: http://airbladesoftware.com


## Licence

CssDryer is available under the MIT licence.  See MIT-LICENCE for the details.

Copyright (c) 2006-2008 Andrew Stewart
