
db.createCollection( 'clients', {validator: {$jsonSchema: {bsonType: 'object',title:'clients',required: [         'id_client',          'nom',          'adreça',          'telefon',          'email',          'data_registre',          'recomanat_per'],properties: {id_client: {bsonType: 'int'},nom: {bsonType: 'string'},adreça: {bsonType: 'object',
title:'object',required: [         'Carrer',          'Numero',          'Pis',          'Porta',          'Codi_postal',          'Ciuitat'],properties: {Carrer: {bsonType: 'string'},Numero: {bsonType: 'int'},Pis: {bsonType: 'int'},Porta: {bsonType: 'int'},Codi_postal: {bsonType: 'int'},Ciuitat: {bsonType: 'string'}}},telefon: {bsonType: 'int'},email: {bsonType: 'string'},data_registre: {bsonType: 'timestamp'},recomanat_per: {bsonType: 'int'}}         }      }});  