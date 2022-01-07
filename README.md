# Anon app

Demo app to show what [PostgreSQL anonymizer](https://postgresql-anonymizer.readthedocs.io/en/stable/index.html) can do for us


# Install

```bash
git clone https://github.com/FerPerales/anon_app.git
cd anon_app
bundle install
rails db:migrate
rails server
```

Go to localhost:3000/users to see the original users data

# Anonymize data

## Download PostreSQL anonymizer extension

```bash
git clone https://gitlab.com/dalibo/postgresql_anonymizer.git

```

## Install extension
**Note:** instructions provided for Mac. See [oficial PostgreSQL docs](https://postgresql-anonymizer.readthedocs.io/en/stable/INSTALL.html) to install in a different OS

```bash
export C_INCLUDE_PATH="$(xcrun --show-sdk-path)/usr/include"
make extension
make install
```

## Enable extension for our datatabase


```bash
psql anon_app_development -c "ALTER DATABASE anon_app_development SET session_preload_libraries = 'anon'"
psql anon_app_development -c "CREATE EXTENSION IF NOT EXISTS anon CASCADE;"
```

## Access your database console

```bash
psql anon_app_development
```

**Inside** your database console, run this:

```

SELECT anon.init();

SECURITY LABEL FOR anon ON COLUMN users.first_name
 IS 'MASKED WITH FUNCTION anon.fake_first_name()';

SECURITY LABEL FOR anon ON COLUMN users.last_name
 IS 'MASKED WITH FUNCTION anon.fake_last_name()';

SECURITY LABEL FOR anon ON COLUMN users.street_line1
IS 'MASKED WITH VALUE ''CONFIDENTIAL'' ';

SECURITY LABEL FOR anon ON COLUMN users.street_line2
IS 'MASKED WITH VALUE ''CONFIDENTIAL'' ';

SECURITY LABEL FOR anon ON COLUMN users.zipcode
IS 'MASKED WITH FUNCTION anon.random_zip()';

SECURITY LABEL FOR anon ON COLUMN users.email
IS 'MASKED WITH FUNCTION anon.partial_email(users.email)';

SELECT anon.anonymize_database();
```

Check localhost:300 again and you will see all data anonymized
