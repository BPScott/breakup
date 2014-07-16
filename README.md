Breakup
=======

Breakup is a Sass component that allows you to create multiple CSS files from a
single Sass partial by wrapping your code within breakpoint blocks. It allows
you to abstract what your Sass partials folder looks like from what CSS files
you create. Because of this you can easily create per-breakpoint CSS files (e.g.
base, mobile, tablet and desktop) and fallback files where no styles are wrapped
(e.g. for oldIE which does not support media queries).


## The Problem(s)

The current trend towards OOCSS using Sass results in many small partials -- one
per object. This is excellent for readability and reducing mental overhead until
the complication of creating per-media query stylesheets, and oldIE stylesheets
(where media queries are unsupported) appears. The simplest solution is to
create even more partials named for each component's breakpoint (e.g.
_component.scss & _component_wide.scss) but this results in a proliferation of
partials which shall rapidly introduce noise to your partials folder.


## Breakup's Solution

Breakup allows you to write a single partial per object. By isolating each
breakpoint's code inside a mixin block your output stylesheets can choose what
blocks should be included within them and whether or not those blocks should
even be wrapped inside a media query (for oldIE stylesheets you can serve the
basic styles and the unwrapped wide styles so oldIE is given the wide view).


## Installation

Breakup is compatible with both the origial ruby version of Sass and libsass.
It is available as a rubygem and an npm package. If you don't wish to use either
of these package managers you can also copy
[stylesheets/_breakup.scss](stylesheets/_breakup.scss) into your project and
`@import` it from there, as Breakup is written in pure SCSS and has no external
dependencies.

### Ruby

Breakup is distributed as a Compass plugin.

* Run `gem install breakup` or add breakup to your Gemfile.
* Add `require "breakup"` to the top of your compass.rb
* Add `@import 'breakup';` to your base stylesheets

### Node

Breakup is distributed as an npm package.

* Run `npm install breakup-sass --save-dev`
* Add `@import 'node_modules/breakup-sass/stylesheets/breakup';` to your base
  stylesheets

## Usage

The following examples can also be found in the [examples/](examples) folder

### Setup: Named Blocks & Breakpoints

Blocks are chunks of SCSS to be output, they have arbitrary names. Breakpoints
are blocks that have an attached media query that they shall be wrapped in.

First of all identify where your major breakpoints shall be and define them as a
list of lists (where the sub-list contains two items: the breakpoint name and
its media query it represents):

```SCSS
// _global_variables.scss
$breakup-breakpoints: (
  'thin' '(max-width: 35.999em)',
  'wide' '(min-width: 36em)',
  'full' '(min-width: 61em)'
);
```

Then in your component define the blocks and breakpoints that make up your
component. In this example we want the 'basic' block to be output without any
wrappers, but the 'wide' breakpoint shall be wrapped in an @media block.

```SCSS
// _component.scss
@include breakup-block('basic') {
  .component { background-color: red; }
}

@include breakup-breakpoint('thin') {
  .component { background-color: blue; }
}

@include breakup-breakpoint('wide') {
  .component { background-color: green; }
}
```

### A Single Output File

In your root scss file define what blocks should be rendered by defining the
list `$breakup-included-blocks`:

```SCSS
// example_allblocks.scss
@import 'breakup';
$breakup-included-blocks: ('basic' 'thin' 'wide' 'full');

@import 'partials/global_variables';
@import 'partials/component';
```

This shall output:

```CSS
.component {
  background-color: red;
}

@media (max-width: 35.999em) {
  .component {
    background-color: blue;
  }
}
@media (min-width: 36em) {
  .component {
    background-color: green;
  }
}
```


### Per Media Query Blocks

By changing `$breakpoint-included-blocks` we can change what boxes to include.
To create a stylesheet that contains only our wide styles we can specify just
the 'wide' block:


```SCSS
// example_wideonly.scss
@import 'breakup';
$breakup-included-blocks: ('wide');

@import 'partials/global_variables';
@import 'partials/component';
```

This shall output:

```CSS
@media (min-width: 36em) {
  .component {
    background-color: green;
  }
}
```

### Stripping Media Queries (for oldIE)

OldIE doesn't understand media queries so we need to not wrap our breakpoints
with an @media block, just output their contents as-is. This is controlled with
`$breakup-naked` and `$breakup-breakpoints-allow-naked`. `$breakup-naked: true`
tells breakup that it should not not wrap breakpoints up.
`$breakup-breakpoints-allow-naked` is a list of breakpoints that should be
output when `$breakup-naked` is true. By default this is empty and any
breakpoints not specified shall be not be output, even if they are referenced in
`$breakup-included-blocks`.

```SCSS
// example_oldie.scss
@import 'breakup.scss';

$breakup-included-blocks: ('basic' 'wide' 'full');
$breakup-naked: true;
$breakup-breakpoints-allow-naked: ('wide' 'full');

@import 'partials/global_variables';
@import 'partials/component';
```

This shall output:

```CSS
.component {
  background-color: red;
}

.component {
  background-color: green;
}
```

### Tweakpoints

Often we want smaller changes to occur at points between our major breakpoints.
Instead of breaks in layout they are minor adjustments --
[tweakpoints](http://adactio.com/journal/6044/). This can be accomplished by
wrapping a `breakup-media` within a `breakup-block`:

```SCSS
// _component.scss
@include breakup-block('wide') {
  @include breakup-media('(min-width: 40em)') {
    .component {
      background-color: green;
    }
  }
}
```

Breakup provides a convenience method for this so the following is a shorthand
equivalent:

```SCSS
// _component.scss
@include breakup-tweakpoint('(min-width: 40em)', 'wide') {
  .component {
    background-color: green;
  }
}
```


## TODO

More usage examples and tests coming soon.


## Prior Art

The bulk of this project was conceived prior to learning about
[Jacket](https://github.com/Team-Sass/jacket) and
[Breakpoint](http://breakpoint-sass.com/). You could do something pretty
similar by combining the two of them, but I didn't feel like I needed the
extra overhead.
