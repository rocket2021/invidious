# CHANGELOG


## v2.20240825.2 (2024-08-26)

This releases fixes the container tags pushed on quay.io.
Previously, the ARM64 build was released under the `latest` tag, instead of `latest-arm64`.

### Full list of pull requests merged since the last release (newest first)

CI: Fix docker container tags ([#4883], by @SamantazFox)

[#4877]: https://github.com/iv-org/invidious/pull/4877


## v2.20240825.1 (2024-08-25)

Add patch component to be [semver] compliant and make github actions happy.

[semver]: https://semver.org/

### Full list of pull requests merged since the last release (newest first)

Allow manual trigger of release-container build ([#4877], thanks @syeopite)

[#4877]: https://github.com/iv-org/invidious/pull/4877


## v2.20240825.0 (2024-08-25)

### New features & important changes

#### For users

* The search bar now has a button that you can click!
* Youtube URLs can be pasted directly in the search bar. Prepend search query with a
  backslash (`\`) to disable that feature (useful if you need to search for a video whose
  title contains some youtube URL).
* On the channel page the "streams" tab can be sorted by either: "newest", "oldest" or "popular"
* Lots of translations have been updated (thanks to our contributors on Weblate!)
* Videos embedded in local HTML files (e.g: a webpage saved from a blog) can now be played

#### For instance owners

* Invidious now has the ability to provide a `po_token` and `visitordata` to Youtube in order to
  circumvent current Youtube restrictions.
* Invidious can use an (optional) external signature server like [inv_sig_helper]. Please note that
  some videos can't be played without that signature server.
* The Helm charts were moved to a separate repo: https://github.com/iv-org/invidious-helm-chart
* We have changed how containers are released: the `latest` tag now tracks tagged releases, whereas
  the `master` tag tracks the most recent commits of the `master` branch ("nightly" builds).

[inv_sig_helper]: https://github.com/iv-org/inv_sig_helper

#### For developpers

* The versions of Crystal that we test in CI/CD are now: `1.9.2`, `1.10.1`, `1.11.2`, `1.12.1`.
  Please note that due to a bug in the `libxml` bindings (See [#4256]), versions prior to `1.10.0`
  are not recommended to use.
* Thanks to @syeopite, the code is now [ameba] compliant.
* Ameba is part of our CI/CD pipeline, and its rules will be enforced in future PRs.
* The transcript code has been rewritten to permit transcripts as a feature rather than being
  only a workaround for captions. Trancripts feature is coming soon!
* Various fixes regarding the logic interacting with Youtube
* The `sort_by` parameter can be used on the `/api/v1/channels/{id}/streams` endpoint. Accepted
  values are: "newest", "oldest" and "popular"

[ameba]: https://github.com/crystal-ameba/ameba
[#4256]: https://github.com/iv-org/invidious/issues/4256


### Bugs fixed

#### User-side

* Channels: fixed broken "subscribers" and "views" counters
* Watch page: playback position is reset at the end of a video, so that the next time this video
  is watched, it will start from the beginning rather than 15 seconds before the end
* Watch page: the items in the "add to playlist" drop down are now sorted alphabetically
* Videos: the "genre" URL is now always pointing to a valid webpage
* Playlists: Fixed `Could not parse N episodes` error on podcast playlists
* All external links should now have the [`rel`] attibute set to `noreferrer noopener` for
  increased privacy.
* Preferences: Fixed the admin-only "modified source code" input being ignored
* Watch/channel pages: use the full image URL in `og:image` and `twitter:image` meta tags

[`rel`]: https://developer.mozilla.org/en-US/docs/Web/HTML/Attributes/rel

#### API

* fixed the `local` parameter not applying to `formatStreams` on `/api/v1/videos/{id}`
* fixed an `Index out of bounds` error hapenning when a playlist had no videos
* fixed duplicated query parameters in proxied video URLs
* Return actual video height/width/fps rather than hard coded values
* Fixed the `/api/v1/popular` endpoint not returning a proper error code/message when the
  popular page/endpoint are disabled.


### Full list of pull requests merged since the last release (newest first)

* HTML: Sort playlists alphabetically in watch page drop down ([#4853], by @SamantazFox)
* Videos: Fix XSS vulnerability in description/comments ([#4852], thanks _anonymous_)
* YtAPI: Bump client versions ([#4849], by @SamantazFox)
* SigHelper: Fix inverted time comparison in 'check_update' ([#4845], by @SamantazFox)
* Storyboards: Various fixes and code cleaning ([#4153], by SamantazFox)
* Fix lint errors introduced in #4146 and #4295 ([#4876], thanks @syeopite)
* Search: Add support for Youtube URLs ([#4146], by @SamantazFox)
* Channel: Render age restricted channels ([#4295], thanks @ChunkyProgrammer)
* Ameba: Miscellaneous fixes ([#4807], thanks @syeopite)
* API: Proxy formatStreams URLs too ([#4859], thanks @colinleroy)
* UI: Add search button to search bar ([#4706], thanks @thansk)
* Add ability to set po_token and visitordata ID ([#4789], thanks @unixfox)
* Add support for an external signature server ([#4772], by @SamantazFox)
* Ameba: Fix Naming/VariableNames ([#4790], thanks @syeopite)
* Translations update from Hosted Weblate ([#4659])
* Ameba: Fix Lint/UselessAssign ([#4795], thanks @syeopite)
* HTML: Add rel="noreferrer noopener" to external links ([#4667], thanks @ulmemxpoc)
* Remove unused methods in Invidious::LogHandler ([#4812], thanks @syeopite)
* Ameba: Fix Lint/NotNilAfterNoBang ([#4796], thanks @syeopite)
* Ameba: Fix unused argument Lint warnings ([#4805], thanks @syeopite)
* Ameba: i18next.cr fixes ([#4806], thanks @syeopite)
* Ameba: Disable rules ([#4792], thanks @syeopite)
* Channel: parse subscriber count and channel banner ([#4785], thanks @ChunkyProgrammer)
* Player: Fix playback position of already watched videos ([#4731], thanks @Fijxu)
* Videos: Fix genre url being unusable ([#4717], thanks @meatball133)
* API: Fix out of bound error on empty playlists ([#4696], thanks @Fijxu)
* Handle playlists cataloged as Podcast ([#4695], thanks @Fijxu)
* API: Fix duplicated query parameters in proxied video URLs ([#4587], thanks @absidue)
* API: Return actual stream height, width and fps ([#4586], thanks @absidue)
* Preferences: Fix handling of modified source code URL ([#4437], thanks @nooptek)
* API: Fix URL for vtt subtitles ([#4221], thanks @karelrooted)
* Channels: Add sort options to streams ([#4224], thanks @src-tinkerer)
* API: Fix error code for disabled popular endpoint ([#4296], thanks @iBicha)
* Allow embedding videos in local HTML files ([#4450], thanks @tomasz1986)
* CI: Bump Crystal version matrix ([#4654], by @SamantazFox)
* YtAPI: Remove API keys like official clients ([#4655], by @SamantazFox)
* HTML: Use full URL in the og:image property ([#4675], thanks @Fijxu)
* Rewrite transcript logic to be more generic ([#4747], thanks @syeopite)
* CI: Run Ameba ([#4753], thanks @syeopite)
* CI: Add release based containers ([#4763], thanks @syeopite)
* move helm chart to a dedicated github repository ([#4711], thanks @unixfox)

[#4146]: https://github.com/iv-org/invidious/pull/4146
[#4153]: https://github.com/iv-org/invidious/pull/4153
[#4221]: https://github.com/iv-org/invidious/pull/4221
[#4224]: https://github.com/iv-org/invidious/pull/4224
[#4295]: https://github.com/iv-org/invidious/pull/4295
[#4296]: https://github.com/iv-org/invidious/pull/4296
[#4437]: https://github.com/iv-org/invidious/pull/4437
[#4450]: https://github.com/iv-org/invidious/pull/4450
[#4586]: https://github.com/iv-org/invidious/pull/4586
[#4587]: https://github.com/iv-org/invidious/pull/4587
[#4654]: https://github.com/iv-org/invidious/pull/4654
[#4655]: https://github.com/iv-org/invidious/pull/4655
[#4659]: https://github.com/iv-org/invidious/pull/4659
[#4667]: https://github.com/iv-org/invidious/pull/4667
[#4675]: https://github.com/iv-org/invidious/pull/4675
[#4695]: https://github.com/iv-org/invidious/pull/4695
[#4696]: https://github.com/iv-org/invidious/pull/4696
[#4706]: https://github.com/iv-org/invidious/pull/4706
[#4711]: https://github.com/iv-org/invidious/pull/4711
[#4717]: https://github.com/iv-org/invidious/pull/4717
[#4731]: https://github.com/iv-org/invidious/pull/4731
[#4747]: https://github.com/iv-org/invidious/pull/4747
[#4753]: https://github.com/iv-org/invidious/pull/4753
[#4763]: https://github.com/iv-org/invidious/pull/4763
[#4772]: https://github.com/iv-org/invidious/pull/4772
[#4785]: https://github.com/iv-org/invidious/pull/4785
[#4789]: https://github.com/iv-org/invidious/pull/4789
[#4790]: https://github.com/iv-org/invidious/pull/4790
[#4792]: https://github.com/iv-org/invidious/pull/4792
[#4795]: https://github.com/iv-org/invidious/pull/4795
[#4796]: https://github.com/iv-org/invidious/pull/4796
[#4805]: https://github.com/iv-org/invidious/pull/4805
[#4806]: https://github.com/iv-org/invidious/pull/4806
[#4807]: https://github.com/iv-org/invidious/pull/4807
[#4812]: https://github.com/iv-org/invidious/pull/4812
[#4845]: https://github.com/iv-org/invidious/pull/4845
[#4849]: https://github.com/iv-org/invidious/pull/4849
[#4852]: https://github.com/iv-org/invidious/pull/4852
[#4853]: https://github.com/iv-org/invidious/pull/4853
[#4859]: https://github.com/iv-org/invidious/pull/4859
[#4876]: https://github.com/iv-org/invidious/pull/4876


## v2.20240427 (2024-04-27)

Major bug fixes:
 * Videos: Use android test suite client (#4650, thanks @SamantazFox)
 * Trending: Un-nest category if this is the only one (#4600, thanks @ChunkyProgrammer)
 * Comments: Add support for new format (#4576, thanks @ChunkyProgrammer)

Minor bug fixes:
 * API: Add bitrate to formatStreams too (#4590, thanks @absidue)
 * API: Add 'authorVerified' field on recommended videos (#4562, thanks @ChunkyProgrammer)
 * Videos: Add support for new likes format (#4462, thanks @ChunkyProgrammer)
 * Proxy: Handle non-200 HTTP codes on DASH manifests (#4429, thanks @absidue)

Other improvements:
 * Remove legacy proxy code (#4570, thanks @syeopite)
 * API: convey info "is post live" from Youtube response (#4569, thanks @ChunkyProgrammer)
 * API: Parse channel's tags (#4294, thanks @ChunkyProgrammer)
 * Translations update from Hosted Weblate (#4164, thanks to our many translators)
