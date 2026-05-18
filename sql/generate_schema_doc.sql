-- This script generates a text-based description of the schema for the report
SELECT
    table_name,
    column_name,
    data_type,
    is_nullable,
    column_default
FROM
    information_schema.columns
WHERE
    table_schema = 'public'
ORDER BY
    table_name, ordinal_position;
