# CHANGELOG

## [1.0.0] - 2021-01-04
### Added
- It added the `libs` folder that have this files:
  - code-style.tex
  - emblemufc.pdf
  - logoUFCbackground.png
  - preamble.tex
  - ufc_format.cls
- It added the `code` folder with some example codes
  - helloworld.java
  - index.html
  - main.py
  - source.c
- It was add the `.gitignore` file

## [1.1.0] - 2021-01-10
### Fixed
- Fixed the bug of multi-columns.
- Algorithms colors

### Added
- It added the command `\source{}` in the figures.

## [1.2.0] - 2021-01-15
### Fixed
- Adjustment of the documentation
- Adjustment of the `code_styles.tex` file

## [1.3.0] - 2021-01-22
### Added
- It added a new command: `\email{}`
- It added a new default slide (the last slide)

### Fixed
- Adjustment the 'Sumario' slide for two columns
- Fixed the reference's slide bug

## [1.3.1] - 2024-02-26
### Added
- Added a CITATION.cff file [suggested by Joao Pedro Holanda - https://github.com/Joao-Pedro-P-Holanda]
- Added the `.github/release.yml` file

## [GREI edition] - 2026-11-03
### Changed
- Recolored the theme (`blue_theme`, `yellow`, `green_ufc`) to the GREI - Grupo de Redes Elétricas Inteligentes palette (forest green, yellow and light blue), based on https://grei-ufc.github.io/.
- Replaced `libs/emblemufc.pdf` and `libs/ufcpixel.png` with the GREI logo assets; `libs/logoUFCbackground.png` and its `1.7\paperwidth` crop were kept as the original UFC coat of arms watermark.
- Added `libs/grei_full_logo.pdf` (full GREI logo with wordmark).
- Updated `document.tex` institute block and the figures example to reference GREI.
- Added the `sitegrei` reference in `references.bib`.