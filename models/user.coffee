module.exports = (sequelize, DataTypes) ->
  model = define_model(sequelize, DataTypes)
  
define_model = (sequelize, DataTypes) ->
  properties =
    id:
      type: DataTypes.INTEGER
      allowNull: false
      
    username:
      type: DataTypes.STRING
      allowNull: false
      
    password:
      type: DataTypes.STRING
      allowNull: false

    email:
      type: DataTypes.STRING
      allowNull: true

  model_options =
    freezeTableName: true
    paranoid: false
    underscored: true
    timestamps: false
    
  sequelize.define 'user', properties, model_options
