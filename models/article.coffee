module.exports = (sequelize, DataTypes) ->
  model = define_model(sequelize, DataTypes)
  
define_model = (sequelize, DataTypes) ->
  properties = 
    id:
      type: DataTypes.INTEGER
      allowNull: false
      
    title:
      type: DataTypes.STRING
      allowNull: false
      
    content:
      type: DataTypes.STRING
      allowNull: false
  
  model_options = 
    freezeTableName: true
    paranoid: false
    underscored: true
    timestamps: true
    
  sequelize.define 'article', properties, model_options
