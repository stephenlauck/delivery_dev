name 'delivery_dev'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures delivery_dev'
long_description 'Installs/Configures delivery_dev'
version '0.3.0'

depends 'chef-ingredient'
depends 'chef-server-ctl'
depends 'hostsfile'
depends 'delivery_build'
depends 'consul'

# ha
depends 'lsyncd'
