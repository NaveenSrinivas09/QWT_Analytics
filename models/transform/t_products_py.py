# from snowflake.snowpark.functions import col, iff

# # def prodavailable(x, y):
# #     return x - y


# def model(dbt, session):
#     dbt.config(materialized="table", schema="transform")
#     temp_df = dbt.ref("stg_products")

#     df = temp_df.with_column(
#         "productavailability",
#         iff(
#             (col("UnitsInStock") - col("UnitsOnOrder")) > 0,
#             "product is not available",
#             "product is available",
#         ),
#     )

#     return df
