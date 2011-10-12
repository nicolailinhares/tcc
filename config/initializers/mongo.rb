#MongoMapper.setup(Rails.configuration.database_configuration, Rails.env, :logger => Rails.logger)
if ENV['MONGOLAB_URI'] then
  MongoMapper.config = {
    Rails.env => { 'uri' => ENV['MONGOLAB_URI'] } }
  MongoMapper.connect(Rails.env)
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
  MongoMapper.database = "#tcc-#{Rails.env}"
end