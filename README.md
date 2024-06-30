# pelican-build-pages

A simple GitHub Action for producing Pelican build artifacts compatible with GitHub Pages.

## Based on the following projects

[jekyll-build-pages](https://github.com/actions/jekyll-build-pages)

[pelican-to-github-pages](https://github.com/rehanhaider/pelican-to-github-pages)


## Usage

> ⚠️ No full testing at this time

A basic Pages deployment workflow with the `pelican-build-pages` action looks like this.

```yaml
name: Build Pelican site
on:
 push:
   branches: ["main"]
permissions:
  contents: read
  pages: write
  id-token: write
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Pages
        uses: actions/configure-pages@v5
      - name: Build
        uses: SnDream/pelican-build-pages@v2
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
  deploy:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
```

To write to a different destination directory, match the inputs of both the `pelican-build-pages` and [`upload-pages-artifact`](https://github.com/actions/upload-pages-artifact) actions.

```yaml
steps:
  - name: Build
    uses: actions/pelican-build-pages@v1
    with:
      destination: "./output"
  - name: Upload artifact
    uses: actions/upload-pages-artifact@v3
    with:
      path: "./output"
```

### Action inputs

| Input | Default | Description |
|-------|---------|-------------|
| `source` | `content` | The directory to build from |
| `destination` | `./_site` | The directory to write output into<br>(this should match the `path` input of the [`actions/upload-pages-artifact`](https://github.com/actions/upload-pages-artifact) action) |
| `configfile` | `pelicanconf.py` | Override the default `pelicanconf.py` config file |
| `build_revision` | `$GITHUB_SHA` | The SHA-1 of the Git commit for which the build is running |
| `token` | `$GITHUB_TOKEN` | The GitHub token used to authenticate API requests |

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE).
