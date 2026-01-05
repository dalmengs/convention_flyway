-- =========================================================
-- Rename order table to userorder (order is a SQL reserved word)
-- =========================================================

-- Rename table
ALTER TABLE "order" RENAME TO userorder;

-- Rename indexes
ALTER INDEX idx_order_order_id RENAME TO idx_userorder_order_id;
ALTER INDEX idx_order_aggregate_id RENAME TO idx_userorder_aggregate_id;

