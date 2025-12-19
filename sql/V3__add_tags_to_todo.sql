-- =========================================================
-- Tags table (1:N relationship with todos)
-- =========================================================

CREATE TABLE tags (
    seq BIGSERIAL PRIMARY KEY,
    id VARCHAR(26) NOT NULL UNIQUE,

    todo_id VARCHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT fk_tags_todo_id
        FOREIGN KEY (todo_id)
        REFERENCES todos(id)
        ON DELETE CASCADE
);

-- =========================================================
-- Indexes
-- =========================================================

CREATE INDEX idx_tags_seq ON tags(seq);
CREATE INDEX idx_tags_todo_id ON tags(todo_id);
CREATE INDEX idx_tags_name ON tags(name);

