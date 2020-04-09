let PgConfig =
      { Type =
          { host : Text
          , port : Natural
          , user : Text
          , password : Optional Text
          , dbname : Text
          }
      , default = { host = "localhost", port = 5432 }
      }

in  PgConfig::{ user = "andrew", password = None Text, dbname = "plants" }
