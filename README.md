## Washington Double Star Catalog Tools

This is a handy and practical toolkit for astronomers interested in doubles star
observing, and selecting various populations of double stars against various
attributes, via SQL/sqlite3 tools. The data comes from the legendary, venerable,
and largest catalog for double-stars in history: the Washington Double Star Catalog.

This kit makes it easy for anyone to get up and running, since it is also
distributed as a ready-made `docker` container. But even if you don't use `docker`,
it is quite easy to get going anyway by cloning the `github` repo.

### Running with `docker`:
  * If you run a decent OS (`Linux` or `MacOS`) with a decent shell, these should work:
    * Option 1 (fetching the image and running it): `./fetch_and_run_docker.sh`
    * Option 2 (building the image locally, and running it): `./build_and_run_docker.sh`
  * If you are stuck with a bad OS like `Windows` (truly sorry), but have `docker` running, you can do:
    * `docker pull akjmicro17/wds-tools`
    * `docker run -it akjmicro17/wds-tools`

### Or, grab the code via `github`:

`git clone https://github.com/akjmicro/wds-tools`

### How to use

Typically, you will only need to just fire up an `sqlite3` command against the
database, and just query using normal SQL. Understanding the use of SQL is beyond
the scope of this documentation, however, a couple of examples might help:

```
sqlite3 wds_doubles.db

# (you'll now be dropped into an `sqlite3` prompt...)
select * from medium_doubles;
select * from tight_doubles where (mag2 - mag1) < 4;
```

Have a look at the setup of the database with certain views, etc. that exist in
`dbsetup.sql`. Feel free to modify those or add to them to your heart's content.

In the event you feel the data is not up-to-date, just run `refresh_data_setup.sh`

### TODO

Eventually, I'll add a SkySafari observing list export script here.

### Odds and ends
Contact me with questions, or if you want to add to the project.

Cheers, and enjoy those doubles!
