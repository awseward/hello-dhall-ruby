let DataType = < INT | BIGINT | TEXT >

let Constraint = < NULL | `NOT NULL` >

let Column =
      { Type = { name : Text, type : DataType, constraints : List Constraint }
      , default = {=}
      }

let Table =
      { Type = { name : Text, columns : List Column.Type }, default = {=} }

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

in  { pg = PgConfig::{
      , user = "andrew"
      , password = None Text
      , dbname = "plants"
      }
    , tables =
      [ Table::{
        , name = "genuses"
        , columns =
          [ Column::{
            , name = "name"
            , type = DataType.TEXT
            , constraints = [ Constraint.`NOT NULL` ]
            }
          ]
        }
      ]
    }
