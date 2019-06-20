require './config/environment'

begin
  fi_check_migration

  use Rack::MethodOverride
  run ApplicationController
  # Make sure to add these when creating new controllers!!
  use ArtistsController
  use SongsController
  use GenresController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
