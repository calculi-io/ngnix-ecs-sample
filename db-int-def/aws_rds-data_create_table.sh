#!/bin/bash

clusterARN=$(aws rds describe-db-clusters --db-cluster-identifier ${RDS_INT_CLUSTER_NAME} | jq -r '.DBClusters | .[0] | .DBClusterArn')
dbSecretsARN=$(aws secretsmanager describe-secret --secret-id ${RDS_INT_CLUSTER_NAME} | jq -r '.ARN')

aws rds-data execute-statement --resource-arn ${clusterARN} --database ${RDS_DATABASE_NAME} --secret-arn ${dbSecretsARN} --sql "create table if not exists int_array_int (vector  int[][])"
