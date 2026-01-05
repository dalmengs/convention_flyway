-- =========================================================
-- Wallet, Wallet Outbox, and Order tables
-- =========================================================

CREATE TABLE wallet (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    user_id VARCHAR(255) NOT NULL,

    amount BIGINT NOT NULL DEFAULT 0,
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE wallet_outbox (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    aggregate_id VARCHAR(255) NOT NULL,
    event_type VARCHAR(255) NOT NULL,
    payload JSONB NOT NULL,
    status VARCHAR(50) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE "order" (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    order_id VARCHAR(255) NOT NULL,
    aggregate_id VARCHAR(255) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    amount BIGINT NOT NULL,
    status VARCHAR(50) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- Indexes
-- =========================================================

-- wallet indexes
CREATE INDEX idx_wallet_user_id ON wallet(user_id);

-- wallet_outbox indexes
CREATE INDEX idx_wallet_outbox_status_created_at ON wallet_outbox(status, created_at);
CREATE INDEX idx_wallet_outbox_aggregate_id ON wallet_outbox(aggregate_id);

-- order indexes
CREATE INDEX idx_order_order_id ON "order"(order_id);
CREATE INDEX idx_order_aggregate_id ON "order"(aggregate_id);

