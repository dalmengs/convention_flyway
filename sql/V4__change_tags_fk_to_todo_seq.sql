-- =========================================================
-- Change tags foreign key from todo_id to todo_seq
-- =========================================================

-- Drop existing foreign key constraint
ALTER TABLE tags
DROP CONSTRAINT fk_tags_todo_id;

-- Drop existing index
DROP INDEX IF EXISTS idx_tags_todo_id;

-- Drop todo_id column
ALTER TABLE tags
DROP COLUMN todo_id;

-- Add todo_seq column
ALTER TABLE tags
ADD COLUMN todo_seq BIGINT NOT NULL;

-- Add foreign key constraint referencing todos.seq
ALTER TABLE tags
ADD CONSTRAINT fk_tags_todo_seq
    FOREIGN KEY (todo_seq)
    REFERENCES todos(seq)
    ON DELETE CASCADE;

-- Recreate index for todo_seq
CREATE INDEX idx_tags_todo_seq ON tags(todo_seq);

