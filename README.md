# GSA Small Business Experience

The GSA Small Business Experience project seeks to improve the experience of
small and disadvantaged businesses working with the General Services
Administration. Our process may serve as a model for improving the user
experience of further resources in GSA.gov.

## Information about this repository

This code uses the [Jekyll](https://jekyllrb.com) site engine and built with Ruby, and is based off of the [Federalist](https://federalist.18f.gov/) template [federalist-uswds-jekyll](https://github.com/18F/federalist-uswds-jekyll). It incorporates the [U.S. Web Design System v 2.0](https://v2.designsystem.digital.gov).

This repository uses GitHub Actions to deploy via Federalist.

As we did not need blog functionality, posts / drafts / etc were removed from this code base.

## Development

### Installation for development
    $ git clone https://github.com/18F/gsa-small-business-experience
    $ cd gsa-small-business-experience

In order to run tests you will also need to install [pa11y-ci](https://github.com/pa11y/pa11y-ci).


### Running the application

You will need to install Ruby (version in `.ruby-version`) and node + npm

    $ npm install
    $ bundle install
    $ npm start (same as bundle exec jekyll serve)

To build but not serve the site, run `npm run build` or `bundle exec jekyll build`.

Open your web browser to [localhost:4000](http://localhost:4000/) to view your
site.

### Tests and code scanning

    $ npm test

npm test will run the following scanners:

- [woke](https://github.com/get-woke/woke): identifies non-inclusive language ([CI action](https://github.com/marketplace/actions/run-woke))
- [htmlproofer](https://github.com/gjtorikian/html-proofer): checks for valid HTML, broken links, etc
- [pa11y-ci](https://github.com/pa11y/pa11y-ci): accessibility (config `.pa11yci`)
- [rspec](https://rspec.info/) + [capybara](https://github.com/teamcapybara/capybara): spins up with puma, checks content of HTML for presence of elements and behavior

`woke` will not scan anything appearing in your `.gitignore` file by default.
You may also configure `woke` to ignore additional paths by modifying the
`.wokeignore` file.

`pa11y-ci` may be configured with `.pa11yci`. Although you may choose to run this with
the `:sitemap` option, results appear to be better when relying on a list of URLs in
`.pa11yci`.

The `rspec` tests are available in the `/spec` directory

#### Github actions

When opening a pull request, the above actions will run automatically.
__Currently, the Federalist USWDS template is
[experiencing an issue](https://github.com/18F/federalist-uswds-jekyll/issues/223)
with builds intermittently failing__.  This means that either the scans or the
deployment to Federalist may fail unexpectedly. We recommend running `npm test`
locally before pushing, as well as `npm run build` in order to confirm that
your branch is working since the scanners and deployment may not get a chance
to run in GitHub when the building step fails.

## Technologies you should be familiarize yourself with

- [Jekyll](https://jekyllrb.com/docs/) - The primary site engine that builds your code and content.
- [Front Matter](https://jekyllrb.com/docs/frontmatter) - The top of each page/post includes keywords within `--` tags. This is meta data that helps Jekyll build the site, but you can also use it to pass custom variables.
- [U.S. Web Design System v 2.0](https://v2.designsystem.digital.gov)

## How to edit

### Configuration

- We try to keep configuration options to a minimum so you can easily change functionality. You should review `_config.yml` to see the options that are available to you. There are a few values on top that you **need** to change. They refer to the agency name and contact information. The rest of `_config.yml` has a range of more advanced options.

- `search/index.html` is used by search.gov.

### Assets

- The contents inside `assets/` folder store your Javascript, SCSS/CSS, images, and other media assets are managed by  [jekyll-assets](https://github.com/envygeeks/jekyll-assets).  Assets are combined, compressed, and automatically available in your theme

- Do not edit files in the `_site/` folder. These files are auto-generated, and any change you make in the folder will be overwritten.

- To edit the look and feel of the site, you need to edit files in `_includes/` folder, which render key components, like the menu, side navigation, and logos.

- `_layouts/` may require the least amount of editing of all the files since they are primarily responsible for printing the content.

### Customizing opportunity explorer quiz and results

The questions and answers for the opportunity explorer are found in:

- `_data/opportunity-explorer-questions.yml`
- `_data/opportunity-explorer-answers.yml`

The logic for selecting which programs and set-asides to display is in `_assets/js/opportunity-explorer.js`.

Programs are agnostic of set-aside types (although we recognize there are GWACs created for specific socio-economic small businesses). Each rule for program display defines the relevant industries, if the company is well-established (>2 years old, $25K income), and if their products / services are above the micro-purchase threshold.

`true` means a selection of "Yes" for that question is required to display the program, `false` means "No" is required, and `null` indicates that the question is irrelevant for that particular program.

For example, the "Telecommunications and network services" IDIQ program will be displayed if the user selects either "all industries" or "IT: Satellite Communications" as their industry, and indicates that they are selling above the micro-purchase threshold. Their answer about the age of their business and profits is not considered, as it is `null`.

```json
"communications" : {
  "industry" : ["all", "itsatcom"],
  "revenue" : null,
  "purchase" : false,
}
```

## Public domain

This project is in the worldwide [public domain](LICENSE.md). As stated in [CONTRIBUTING](CONTRIBUTING.md):

> This project is in the public domain within the United States, and copyright
> and related rights in the work worldwide are waived through the [CC0 1.0
> Universal public domain dedication](https://creativecommons.org/publicdomain/zero/1.0/).
>
> All contributions to this project will be released under the CC0 dedication.
> By submitting a pull request, you are agreeing to comply with this waiver of
> copyright interest.
