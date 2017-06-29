# Article Readability

A simple, quick and dirty, article readability detector. Based on [Red Pather's article](https://blog.redpanthers.co/odyssey-in-rails/). It is a simple Sinatra web application where you paste in a URL, a CSS selector for the article, and hit "Run". It will output useful stats on the article.

## Installation

### Local

```bash
bundle install
rackup
```

### Heroku

Deploy to Heroku, there is a `Procfile` setup already.

## Example

Entering: `https://blog.prototypr.io/6-animation-guidelines-for-ux-design-74c90eb5e47a@.section-content .sectionLayout--insetColumn`

Produces the following results for the article:

```text
Letters: 12274
Syllables: 4138
Words: 2807
Sentences: 164
Avg. Words / Sentance: 17.12
Avg. Syllables / Word: 1.47

Score: 64.7
Reading Level: 8th to 9th Grade
Plain english
```
