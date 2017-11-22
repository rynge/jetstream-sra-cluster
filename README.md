# jetstream-sra-cluster
Sets up an autoscaled Jetstream cluster for SRA work



pip install shade

/root/.config/openstack/clouds.yml

clouds:
 jetstream_iu:
   region_name: RegionOne
   auth:
     username: '[username]'
     password: '[password]'
     user_domain_name: 'tacc'
     project_id: '84b7acc0f5fa42f1a22c1f8c0d9e04a2'
     project_name: 'TG-BIO170028'
     auth_url: 'https://iu.jetstream-cloud.org:5000/v3'




