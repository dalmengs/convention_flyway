-- =========================================================
-- Todo table
-- =========================================================

CREATE TABLE todos (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    title VARCHAR(255) NOT NULL,
    description TEXT,

    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    is_deleted   BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- Indexes
-- =========================================================

CREATE INDEX idx_todos_seq ON todos(seq);
CREATE INDEX idx_todos_is_completed ON todos(is_completed);
CREATE INDEX idx_todos_is_deleted ON todos(is_deleted);

CREATE INDEX idx_todos_active_seq
    ON todos(is_deleted, seq);
