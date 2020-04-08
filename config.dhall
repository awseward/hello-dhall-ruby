let PgConfig =
      { Type =
          { host : Text
          , port : Natural
          , user : Text
          , password : Optional Text
          , schema : Text
          , dbname : Text
          }
      , default = { host = "localhost", port = 5432, schema = "public" }
      }

in  PgConfig::{ user = "andrew", password = None Text, dbname = "plants" }
