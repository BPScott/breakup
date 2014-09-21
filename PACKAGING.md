Packaging
=========

Because I do this so rarely I need a thing to remind me

Version bump lib/breakup/version.rb and in package.json

Git tag the commit
    git tag 1.0.0 && git push origin 1.0.0

Build gem and release
    gem build breakup.gemspec
    gem push breakup-1.0.0.gem

Build npm package and release

    npm publish .
