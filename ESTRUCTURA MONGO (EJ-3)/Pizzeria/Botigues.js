
db.createCollection( 'Botigues', {validator: {$jsonSchema: {bsonType: 'object',title:'Botigues',required: [         'id_botiga',          'direccion'],properties: {id_botiga: {bsonType: 'objectId'},direccion: {bsonType: 'object',
title:'object',required: [         'carrer',          'numero',          'pis',          'codi_postal',          'ciutat'],properties: {carrer: {bsonType: 'string'},numero: {bsonType: 'int'},pis: {bsonType: 'int'},codi_postal: {bsonType: 'int'},ciutat: {bsonType: 'string'}}}}         }      }});  