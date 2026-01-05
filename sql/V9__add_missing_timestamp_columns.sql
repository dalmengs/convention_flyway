-- =========================================================
-- Add missing timestamp columns (created_at, updated_at) to wallet, wallet_outbox, and order tables
-- =========================================================

-- Add created_at to wallet
ALTER TABLE wallet
ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT NOW();

-- Add updated_at to wallet_outbox
ALTER TABLE wallet_outbox
ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();

-- Add updated_at to order
ALTER TABLE "order"
ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT NOW();

