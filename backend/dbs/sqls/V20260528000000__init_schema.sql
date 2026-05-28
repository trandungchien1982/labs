CREATE TABLE IF NOT EXISTS accounts (
    id          BIGSERIAL PRIMARY KEY,
    account_no  VARCHAR(20)     NOT NULL UNIQUE,
    owner_name  VARCHAR(255)    NOT NULL,
    balance     NUMERIC(19, 4)  NOT NULL DEFAULT 0,
    currency    VARCHAR(3)      NOT NULL DEFAULT 'VND',
    status      VARCHAR(20)     NOT NULL DEFAULT 'ACTIVE',
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS transactions (
    id              BIGSERIAL PRIMARY KEY,
    ref_no          VARCHAR(50)     NOT NULL UNIQUE,
    account_id      BIGINT          NOT NULL REFERENCES accounts(id),
    type            VARCHAR(20)     NOT NULL,
    amount          NUMERIC(19, 4)  NOT NULL,
    currency        VARCHAR(3)      NOT NULL DEFAULT 'VND',
    description     VARCHAR(500),
    status          VARCHAR(20)     NOT NULL DEFAULT 'PENDING',
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_transactions_account_id ON transactions(account_id);
CREATE INDEX IF NOT EXISTS idx_transactions_created_at ON transactions(created_at DESC);
