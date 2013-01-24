#!yaml

# Include the GLOBAL region mapping pillar data here.
# For example: 
# pillar["region_mapping"][0][1]

region_mapping:
  - # Oregon
    - provider: aws
      location: us-west-2
      availability_zone: us-west-2a
    - provider: aws
      location: us-west-2
      availability_zone: us-west-2b
    - provider: aws
      location: us-west-2
      availability_zone: us-west-2c
  - # California
    - provider: aws
      location: us-west-1
      availability_zone: us-west-1b
    - provider: aws
      location: us-west-2
      availability_zone: us-west-1c

