# Flyway Database Migration Guide

이 저장소는 **Flyway를 사용한 데이터베이스 스키마 중앙 관리용 레포지토리**입니다.  
모든 DB 스키마 변경은 **Flyway migration SQL 파일**을 통해서만 이루어지며,  
애플리케이션(Spring 등)은 이 스키마를 **신뢰(validate)** 하는 구조를 따릅니다.

---

## 1. 기본 철학 (Principles)

- Migration SQL 파일이 **DB의 Source of Truth**
- 한 번 적용된 migration 파일은 **절대 수정하지 않음**
- 모든 변경은 **새로운 version migration(V2, V3, …)** 으로 추가
- Flyway는 **자동 diff / push 개념이 없음**
- 명시적이고 재현 가능한 변경만 허용

---

## 2. 디렉토리 구조

```text
convention_flyway/
├── flyway.conf
├── sql/
│   ├── V1__init.sql
│   ├── V2__add_xxx.sql
│   └── V3__modify_xxx.sql
└── README.md
```

- `lyway.conf` : DB 접속 정보 및 Flyway 설정
- `sql/...` : 모든 migration SQL 파일

---

## 3. 네이밍 컨벤션 

`V{version}__{description}.sql`

- V + 숫자 = migration version
- __ (언더바 2개) 반드시 사용
- 설명은 snake_case 사용
- 한 번 적용된 파일은 절대 수정 금지

<br />

[예시] 
```text
V1__init.sql
V2__add_priority_column.sql
V3__add_indexes.sql
```

---

## 4. 실행 

[상태 확인]<br />
`flyway -configFiles=flyway.conf info`

<br />
[마이그레이션]

`flyway -configFiles=flyway.conf migrate`

---

## 5. 테이블 식별자 컨벤션 

[내부 성능용 PK]<br />
`seq BIGSERIAL PRIMARY KEY`

[외부 비즈니스 식별자]<br />
`id VARCHAR(26) NOT NULL UNIQUE`

- auto_increment 컬럼(seq)은 절대 API 응답에 노출하지 않음
- string 기반 id(UUID/ULID/CUID)는 외부 API identity로 사용

---

## 6. 기타 

- Flyway는 `flyway_schema_history` 테이블로 migration 상태를 관리합니다.
- Spring 애플리케이션에서는 Flyway를 비활성화하고, DB 스키마는 Flyway가 관리합니다.