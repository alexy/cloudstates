#!yaml

# Include the GLOBAL region mapping pillar data here.
# For example: 
# pillar["region_mapping"]['1']['1']

region_mapping:
  1:
    1:
      provider: aws
      availability_zone: us-west-2b
      location: us-west-2

    2:
      provider: aws
      availability_zone: us-west-2c
      location: us-west-2
  2:
    1:
      provider: aws
      availability_zone: us-west-1b
      location: us-west-1
    2:
      provider: aws
      availability_zone: us-west-1c
      location: us-west-1

