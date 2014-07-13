
graveyards4
===========

### 4.0.4 (2014-07-13)

- added /blog, and Article object to provide its content
- mapped route /graveyard?id=XXX to Legacy controller (thus release 4.0.4 diminishes 404s).

### 4.0.3 (2014-07-12)

- supports login via Facebook, Twitter, Google+
- allows logged-in users to register Visits and Todos for each cemetery
- scss constructs for easier media queries
- layout tweaks, including changing menu break point

### 4.0.2 (2014-05-31)

- add cemetery list feature (tabular layout)
- add KML format for county & graveyard pages
- auto hide navbar on scrolling
- legacy controller, redirects some old URLs as 301
- button bar on county page

### 4.0.1 (2014-05-30)

- schema.org markup
- facebook buttons
- 404 handler 

### 4.0.0 (2014-05-26)

Complete rewrite of graveyards.com web app as Rails 4.1 project.

- Rails app now at root level of namespace
- Legacy pages accessed via Apache aliases to bypass Rails
- Image management moved into database, rather than based on filenames.
- Twitter Bootstrap used for CSS.
- Source hosted on Github.

