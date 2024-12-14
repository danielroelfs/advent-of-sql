WITH receipts AS (
    SELECT JSONB_ARRAY_ELEMENTS(cleaning_receipts) AS receipt
    FROM santarecords
),

unnested_receipt_items AS (
    SELECT
        receipt ->> 'drop_off' AS drop_off_date,
        receipt ->> 'garment' AS garment,
        receipt ->> 'color' AS color
    FROM receipts
)

SELECT * FROM unnested_receipt_items
WHERE
    1 = 1
    AND garment = 'suit'
    AND color = 'green';
