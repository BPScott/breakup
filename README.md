Breakup
=======

Breakup is a Sass component that allows you to create multiple CSS files from a
single Sass partial by wrapping your code within breakpoint blocks. It
allows you to abstract what your Sass partials folder looks like from what CSS
files you create. Because of this you can easily create per-breakpoint CSS
files (e.g. base, mobile, tablet and desktop) and fallback files where no
styles are wrapped (e.g. for oldIE which does not support media queries).


## TODO

Usage examples and tests coming soon.


## Prior Art

The bulk of this project was conceived prior to learning about
[Jacket](https://github.com/Team-Sass/jacket) and
[Breakpoint](http://breakpoint-sass.com/). You could do something pretty
similar by combining the two of them, but I didn't feel like I needed the
extra overhead.
