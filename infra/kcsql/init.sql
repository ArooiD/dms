CREATE DATABASE keycloak;

ALTER DATABASE keycloak OWNER TO postgres;

\connect keycloak

CREATE TABLE public.admin_event_entity
(
    id               character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id         character varying(255),
    operation_type   character varying(255),
    auth_realm_id    character varying(255),
    auth_client_id   character varying(255),
    auth_user_id     character varying(255),
    ip_address       character varying(255),
    resource_path    character varying(2550),
    representation   text,
    error            character varying(255),
    resource_type    character varying(64)
);


ALTER TABLE public.admin_event_entity
    OWNER TO postgres;

CREATE TABLE public.associated_policy
(
    policy_id            character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy
    OWNER TO postgres;

CREATE TABLE public.authentication_execution
(
    id                 character varying(36) NOT NULL,
    alias              character varying(255),
    authenticator      character varying(36),
    realm_id           character varying(36),
    flow_id            character varying(36),
    requirement        integer,
    priority           integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id       character varying(36),
    auth_config        character varying(36)
);


ALTER TABLE public.authentication_execution
    OWNER TO postgres;

CREATE TABLE public.authentication_flow
(
    id          character varying(36)                                         NOT NULL,
    alias       character varying(255),
    description character varying(255),
    realm_id    character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level   boolean               DEFAULT false                           NOT NULL,
    built_in    boolean               DEFAULT false                           NOT NULL
);


ALTER TABLE public.authentication_flow
    OWNER TO postgres;

CREATE TABLE public.authenticator_config
(
    id       character varying(36) NOT NULL,
    alias    character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config
    OWNER TO postgres;

CREATE TABLE public.authenticator_config_entry
(
    authenticator_id character varying(36)  NOT NULL,
    value            text,
    name             character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry
    OWNER TO postgres;


CREATE TABLE public.broker_link
(
    identity_provider   character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id            character varying(36)  NOT NULL,
    broker_user_id      character varying(255),
    broker_username     character varying(255),
    token               text,
    user_id             character varying(255) NOT NULL
);


ALTER TABLE public.broker_link
    OWNER TO postgres;

CREATE TABLE public.client
(
    id                           character varying(36) NOT NULL,
    enabled                      boolean DEFAULT false NOT NULL,
    full_scope_allowed           boolean DEFAULT false NOT NULL,
    client_id                    character varying(255),
    not_before                   integer,
    public_client                boolean DEFAULT false NOT NULL,
    secret                       character varying(255),
    base_url                     character varying(255),
    bearer_only                  boolean DEFAULT false NOT NULL,
    management_url               character varying(255),
    surrogate_auth_required      boolean DEFAULT false NOT NULL,
    realm_id                     character varying(36),
    protocol                     character varying(255),
    node_rereg_timeout           integer DEFAULT 0,
    frontchannel_logout          boolean DEFAULT false NOT NULL,
    consent_required             boolean DEFAULT false NOT NULL,
    name                         character varying(255),
    service_accounts_enabled     boolean DEFAULT false NOT NULL,
    client_authenticator_type    character varying(255),
    root_url                     character varying(255),
    description                  character varying(255),
    registration_token           character varying(255),
    standard_flow_enabled        boolean DEFAULT true  NOT NULL,
    implicit_flow_enabled        boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console    boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client
    OWNER TO postgres;

CREATE TABLE public.client_attributes
(
    client_id character varying(36)  NOT NULL,
    name      character varying(255) NOT NULL,
    value     text
);


ALTER TABLE public.client_attributes
    OWNER TO postgres;

CREATE TABLE public.client_auth_flow_bindings
(
    client_id    character varying(36)  NOT NULL,
    flow_id      character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings
    OWNER TO postgres;

CREATE TABLE public.client_initial_access
(
    id              character varying(36) NOT NULL,
    realm_id        character varying(36) NOT NULL,
    "timestamp"     integer,
    expiration      integer,
    count           integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access
    OWNER TO postgres;

CREATE TABLE public.client_node_registrations
(
    client_id character varying(36)  NOT NULL,
    value     integer,
    name      character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations
    OWNER TO postgres;

CREATE TABLE public.client_scope
(
    id          character varying(36) NOT NULL,
    name        character varying(255),
    realm_id    character varying(36),
    description character varying(255),
    protocol    character varying(255)
);


ALTER TABLE public.client_scope
    OWNER TO postgres;

CREATE TABLE public.client_scope_attributes
(
    scope_id character varying(36)  NOT NULL,
    value    character varying(2048),
    name     character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes
    OWNER TO postgres;

CREATE TABLE public.client_scope_client
(
    client_id     character varying(255) NOT NULL,
    scope_id      character varying(255) NOT NULL,
    default_scope boolean DEFAULT false  NOT NULL
);


ALTER TABLE public.client_scope_client
    OWNER TO postgres;

CREATE TABLE public.client_scope_role_mapping
(
    scope_id character varying(36) NOT NULL,
    role_id  character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping
    OWNER TO postgres;

CREATE TABLE public.client_session
(
    id             character varying(36) NOT NULL,
    client_id      character varying(36),
    redirect_uri   character varying(255),
    state          character varying(255),
    "timestamp"    integer,
    session_id     character varying(36),
    auth_method    character varying(255),
    realm_id       character varying(255),
    auth_user_id   character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session
    OWNER TO postgres;

CREATE TABLE public.client_session_auth_status
(
    authenticator  character varying(36) NOT NULL,
    status         integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status
    OWNER TO postgres;

CREATE TABLE public.client_session_note
(
    name           character varying(255) NOT NULL,
    value          character varying(255),
    client_session character varying(36)  NOT NULL
);


ALTER TABLE public.client_session_note
    OWNER TO postgres;

CREATE TABLE public.client_session_prot_mapper
(
    protocol_mapper_id character varying(36) NOT NULL,
    client_session     character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper
    OWNER TO postgres;

CREATE TABLE public.client_session_role
(
    role_id        character varying(255) NOT NULL,
    client_session character varying(36)  NOT NULL
);


ALTER TABLE public.client_session_role
    OWNER TO postgres;

CREATE TABLE public.client_user_session_note
(
    name           character varying(255) NOT NULL,
    value          character varying(2048),
    client_session character varying(36)  NOT NULL
);


ALTER TABLE public.client_user_session_note
    OWNER TO postgres;

CREATE TABLE public.component
(
    id            character varying(36) NOT NULL,
    name          character varying(255),
    parent_id     character varying(36),
    provider_id   character varying(36),
    provider_type character varying(255),
    realm_id      character varying(36),
    sub_type      character varying(255)
);


ALTER TABLE public.component
    OWNER TO postgres;

CREATE TABLE public.component_config
(
    id           character varying(36)  NOT NULL,
    component_id character varying(36)  NOT NULL,
    name         character varying(255) NOT NULL,
    value        text
);


ALTER TABLE public.component_config
    OWNER TO postgres;

CREATE TABLE public.composite_role
(
    composite  character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role
    OWNER TO postgres;


CREATE TABLE public.credential
(
    id              character varying(36) NOT NULL,
    salt            bytea,
    type            character varying(255),
    user_id         character varying(36),
    created_date    bigint,
    user_label      character varying(255),
    secret_data     text,
    credential_data text,
    priority        integer
);


ALTER TABLE public.credential
    OWNER TO postgres;

CREATE TABLE public.databasechangelog
(
    id            character varying(255)      NOT NULL,
    author        character varying(255)      NOT NULL,
    filename      character varying(255)      NOT NULL,
    dateexecuted  timestamp without time zone NOT NULL,
    orderexecuted integer                     NOT NULL,
    exectype      character varying(10)       NOT NULL,
    md5sum        character varying(35),
    description   character varying(255),
    comments      character varying(255),
    tag           character varying(255),
    liquibase     character varying(20),
    contexts      character varying(255),
    labels        character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog
    OWNER TO postgres;

CREATE TABLE public.databasechangeloglock
(
    id          integer NOT NULL,
    locked      boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby    character varying(255)
);


ALTER TABLE public.databasechangeloglock
    OWNER TO postgres;

CREATE TABLE public.default_client_scope
(
    realm_id      character varying(36) NOT NULL,
    scope_id      character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope
    OWNER TO postgres;

CREATE TABLE public.event_entity
(
    id                      character varying(36) NOT NULL,
    client_id               character varying(255),
    details_json            character varying(2550),
    error                   character varying(255),
    ip_address              character varying(255),
    realm_id                character varying(255),
    session_id              character varying(255),
    event_time              bigint,
    type                    character varying(255),
    user_id                 character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity
    OWNER TO postgres;

CREATE TABLE public.fed_user_attribute
(
    id                         character varying(36)  NOT NULL,
    name                       character varying(255) NOT NULL,
    user_id                    character varying(255) NOT NULL,
    realm_id                   character varying(36)  NOT NULL,
    storage_provider_id        character varying(36),
    value                      character varying(2024),
    long_value_hash            bytea,
    long_value_hash_lower_case bytea,
    long_value                 text
);


ALTER TABLE public.fed_user_attribute
    OWNER TO postgres;

CREATE TABLE public.fed_user_consent
(
    id                      character varying(36)  NOT NULL,
    client_id               character varying(255),
    user_id                 character varying(255) NOT NULL,
    realm_id                character varying(36)  NOT NULL,
    storage_provider_id     character varying(36),
    created_date            bigint,
    last_updated_date       bigint,
    client_storage_provider character varying(36),
    external_client_id      character varying(255)
);


ALTER TABLE public.fed_user_consent
    OWNER TO postgres;

CREATE TABLE public.fed_user_consent_cl_scope
(
    user_consent_id character varying(36) NOT NULL,
    scope_id        character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope
    OWNER TO postgres;

CREATE TABLE public.fed_user_credential
(
    id                  character varying(36)  NOT NULL,
    salt                bytea,
    type                character varying(255),
    created_date        bigint,
    user_id             character varying(255) NOT NULL,
    realm_id            character varying(36)  NOT NULL,
    storage_provider_id character varying(36),
    user_label          character varying(255),
    secret_data         text,
    credential_data     text,
    priority            integer
);


ALTER TABLE public.fed_user_credential
    OWNER TO postgres;

CREATE TABLE public.fed_user_group_membership
(
    group_id            character varying(36)  NOT NULL,
    user_id             character varying(255) NOT NULL,
    realm_id            character varying(36)  NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership
    OWNER TO postgres;

CREATE TABLE public.fed_user_required_action
(
    required_action     character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id             character varying(255)                                NOT NULL,
    realm_id            character varying(36)                                 NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action
    OWNER TO postgres;

CREATE TABLE public.fed_user_role_mapping
(
    role_id             character varying(36)  NOT NULL,
    user_id             character varying(255) NOT NULL,
    realm_id            character varying(36)  NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping
    OWNER TO postgres;

CREATE TABLE public.federated_identity
(
    identity_provider  character varying(255) NOT NULL,
    realm_id           character varying(36),
    federated_user_id  character varying(255),
    federated_username character varying(255),
    token              text,
    user_id            character varying(36)  NOT NULL
);


ALTER TABLE public.federated_identity
    OWNER TO postgres;

CREATE TABLE public.federated_user
(
    id                  character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id            character varying(36)  NOT NULL
);


ALTER TABLE public.federated_user
    OWNER TO postgres;

CREATE TABLE public.group_attribute
(
    id       character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name     character varying(255)                                                         NOT NULL,
    value    character varying(255),
    group_id character varying(36)                                                          NOT NULL
);


ALTER TABLE public.group_attribute
    OWNER TO postgres;

CREATE TABLE public.group_role_mapping
(
    role_id  character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping
    OWNER TO postgres;

CREATE TABLE public.identity_provider
(
    internal_id                character varying(36) NOT NULL,
    enabled                    boolean DEFAULT false NOT NULL,
    provider_alias             character varying(255),
    provider_id                character varying(255),
    store_token                boolean DEFAULT false NOT NULL,
    authenticate_by_default    boolean DEFAULT false NOT NULL,
    realm_id                   character varying(36),
    add_token_role             boolean DEFAULT true  NOT NULL,
    trust_email                boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id  character varying(36),
    provider_display_name      character varying(255),
    link_only                  boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider
    OWNER TO postgres;

CREATE TABLE public.identity_provider_config
(
    identity_provider_id character varying(36)  NOT NULL,
    value                text,
    name                 character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config
    OWNER TO postgres;

CREATE TABLE public.identity_provider_mapper
(
    id              character varying(36)  NOT NULL,
    name            character varying(255) NOT NULL,
    idp_alias       character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id        character varying(36)  NOT NULL
);


ALTER TABLE public.identity_provider_mapper
    OWNER TO postgres;

CREATE TABLE public.idp_mapper_config
(
    idp_mapper_id character varying(36)  NOT NULL,
    value         text,
    name          character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config
    OWNER TO postgres;

CREATE TABLE public.keycloak_group
(
    id           character varying(36) NOT NULL,
    name         character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id     character varying(36)
);


ALTER TABLE public.keycloak_group
    OWNER TO postgres;

CREATE TABLE public.keycloak_role
(
    id                      character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role             boolean DEFAULT false NOT NULL,
    description             character varying(255),
    name                    character varying(255),
    realm_id                character varying(255),
    client                  character varying(36),
    realm                   character varying(36)
);


ALTER TABLE public.keycloak_role
    OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model
(
    id          character varying(36) NOT NULL,
    version     character varying(36),
    update_time bigint DEFAULT 0      NOT NULL
);


ALTER TABLE public.migration_model
    OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session
(
    user_session_id         character varying(36)                                     NOT NULL,
    client_id               character varying(255)                                    NOT NULL,
    offline_flag            character varying(4)                                      NOT NULL,
    "timestamp"             integer,
    data                    text,
    client_storage_provider character varying(36)  DEFAULT 'local'::character varying NOT NULL,
    external_client_id      character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version                 integer                DEFAULT 0
);


ALTER TABLE public.offline_client_session
    OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session
(
    user_session_id      character varying(36)  NOT NULL,
    user_id              character varying(255) NOT NULL,
    realm_id             character varying(36)  NOT NULL,
    created_on           integer                NOT NULL,
    offline_flag         character varying(4)   NOT NULL,
    data                 text,
    last_session_refresh integer DEFAULT 0      NOT NULL,
    broker_session_id    character varying(1024),
    version              integer DEFAULT 0
);


ALTER TABLE public.offline_user_session
    OWNER TO postgres;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org
(
    id          character varying(255) NOT NULL,
    enabled     boolean                NOT NULL,
    realm_id    character varying(255) NOT NULL,
    group_id    character varying(255) NOT NULL,
    name        character varying(255) NOT NULL,
    description character varying(4000)
);


ALTER TABLE public.org
    OWNER TO postgres;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain
(
    id       character varying(36)  NOT NULL,
    name     character varying(255) NOT NULL,
    verified boolean                NOT NULL,
    org_id   character varying(255) NOT NULL
);


ALTER TABLE public.org_domain
    OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config
(
    policy_id character varying(36)  NOT NULL,
    name      character varying(255) NOT NULL,
    value     text
);


ALTER TABLE public.policy_config
    OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper
(
    id                   character varying(36)  NOT NULL,
    name                 character varying(255) NOT NULL,
    protocol             character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id            character varying(36),
    client_scope_id      character varying(36)
);


ALTER TABLE public.protocol_mapper
    OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config
(
    protocol_mapper_id character varying(36)  NOT NULL,
    value              text,
    name               character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config
    OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm
(
    id                           character varying(36)               NOT NULL,
    access_code_lifespan         integer,
    user_action_lifespan         integer,
    access_token_lifespan        integer,
    account_theme                character varying(255),
    admin_theme                  character varying(255),
    email_theme                  character varying(255),
    enabled                      boolean               DEFAULT false NOT NULL,
    events_enabled               boolean               DEFAULT false NOT NULL,
    events_expiration            bigint,
    login_theme                  character varying(255),
    name                         character varying(255),
    not_before                   integer,
    password_policy              character varying(2550),
    registration_allowed         boolean               DEFAULT false NOT NULL,
    remember_me                  boolean               DEFAULT false NOT NULL,
    reset_password_allowed       boolean               DEFAULT false NOT NULL,
    social                       boolean               DEFAULT false NOT NULL,
    ssl_required                 character varying(255),
    sso_idle_timeout             integer,
    sso_max_lifespan             integer,
    update_profile_on_soc_login  boolean               DEFAULT false NOT NULL,
    verify_email                 boolean               DEFAULT false NOT NULL,
    master_admin_client          character varying(36),
    login_lifespan               integer,
    internationalization_enabled boolean               DEFAULT false NOT NULL,
    default_locale               character varying(255),
    reg_email_as_username        boolean               DEFAULT false NOT NULL,
    admin_events_enabled         boolean               DEFAULT false NOT NULL,
    admin_events_details_enabled boolean               DEFAULT false NOT NULL,
    edit_username_allowed        boolean               DEFAULT false NOT NULL,
    otp_policy_counter           integer               DEFAULT 0,
    otp_policy_window            integer               DEFAULT 1,
    otp_policy_period            integer               DEFAULT 30,
    otp_policy_digits            integer               DEFAULT 6,
    otp_policy_alg               character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type              character varying(36) DEFAULT 'totp'::character varying,
    browser_flow                 character varying(36),
    registration_flow            character varying(36),
    direct_grant_flow            character varying(36),
    reset_credentials_flow       character varying(36),
    client_auth_flow             character varying(36),
    offline_session_idle_timeout integer               DEFAULT 0,
    revoke_refresh_token         boolean               DEFAULT false NOT NULL,
    access_token_life_implicit   integer               DEFAULT 0,
    login_with_email_allowed     boolean               DEFAULT true  NOT NULL,
    duplicate_emails_allowed     boolean               DEFAULT false NOT NULL,
    docker_auth_flow             character varying(36),
    refresh_token_max_reuse      integer               DEFAULT 0,
    allow_user_managed_access    boolean               DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer               DEFAULT 0     NOT NULL,
    sso_idle_timeout_remember_me integer               DEFAULT 0     NOT NULL,
    default_role                 character varying(255)
);


ALTER TABLE public.realm
    OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute
(
    name     character varying(255) NOT NULL,
    realm_id character varying(36)  NOT NULL,
    value    text
);


ALTER TABLE public.realm_attribute
    OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups
(
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups
    OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types
(
    realm_id character varying(36)  NOT NULL,
    value    character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types
    OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners
(
    realm_id character varying(36)  NOT NULL,
    value    character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners
    OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations
(
    realm_id character varying(255) NOT NULL,
    locale   character varying(255) NOT NULL,
    texts    text                   NOT NULL
);


ALTER TABLE public.realm_localizations
    OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential
(
    type       character varying(255) NOT NULL,
    form_label character varying(255),
    input      boolean DEFAULT false  NOT NULL,
    secret     boolean DEFAULT false  NOT NULL,
    realm_id   character varying(36)  NOT NULL
);


ALTER TABLE public.realm_required_credential
    OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config
(
    realm_id character varying(36)  NOT NULL,
    value    character varying(255),
    name     character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config
    OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales
(
    realm_id character varying(36)  NOT NULL,
    value    character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales
    OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris
(
    client_id character varying(36)  NOT NULL,
    value     character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris
    OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config
(
    required_action_id character varying(36)  NOT NULL,
    value              text,
    name               character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config
    OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider
(
    id             character varying(36) NOT NULL,
    alias          character varying(255),
    name           character varying(255),
    realm_id       character varying(36),
    enabled        boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id    character varying(255),
    priority       integer
);


ALTER TABLE public.required_action_provider
    OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute
(
    id          character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name        character varying(255)                                                         NOT NULL,
    value       character varying(255),
    resource_id character varying(36)                                                          NOT NULL
);


ALTER TABLE public.resource_attribute
    OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy
(
    resource_id character varying(36) NOT NULL,
    policy_id   character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy
    OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope
(
    resource_id character varying(36) NOT NULL,
    scope_id    character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope
    OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server
(
    id                   character varying(36)  NOT NULL,
    allow_rs_remote_mgmt boolean  DEFAULT false NOT NULL,
    policy_enforce_mode  smallint               NOT NULL,
    decision_strategy    smallint DEFAULT 1     NOT NULL
);


ALTER TABLE public.resource_server
    OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket
(
    id                 character varying(36)  NOT NULL,
    owner              character varying(255) NOT NULL,
    requester          character varying(255) NOT NULL,
    created_timestamp  bigint                 NOT NULL,
    granted_timestamp  bigint,
    resource_id        character varying(36)  NOT NULL,
    scope_id           character varying(36),
    resource_server_id character varying(36)  NOT NULL,
    policy_id          character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket
    OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy
(
    id                 character varying(36)  NOT NULL,
    name               character varying(255) NOT NULL,
    description        character varying(255),
    type               character varying(255) NOT NULL,
    decision_strategy  smallint,
    logic              smallint,
    resource_server_id character varying(36)  NOT NULL,
    owner              character varying(255)
);


ALTER TABLE public.resource_server_policy
    OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource
(
    id                   character varying(36)  NOT NULL,
    name                 character varying(255) NOT NULL,
    type                 character varying(255),
    icon_uri             character varying(255),
    owner                character varying(255) NOT NULL,
    resource_server_id   character varying(36)  NOT NULL,
    owner_managed_access boolean DEFAULT false  NOT NULL,
    display_name         character varying(255)
);


ALTER TABLE public.resource_server_resource
    OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope
(
    id                 character varying(36)  NOT NULL,
    name               character varying(255) NOT NULL,
    icon_uri           character varying(255),
    resource_server_id character varying(36)  NOT NULL,
    display_name       character varying(255)
);


ALTER TABLE public.resource_server_scope
    OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris
(
    resource_id character varying(36)  NOT NULL,
    value       character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris
    OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute
(
    id      character varying(36)  NOT NULL,
    role_id character varying(36)  NOT NULL,
    name    character varying(255) NOT NULL,
    value   character varying(255)
);


ALTER TABLE public.role_attribute
    OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping
(
    client_id character varying(36) NOT NULL,
    role_id   character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping
    OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy
(
    scope_id  character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy
    OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute
(
    name                       character varying(255)                                                         NOT NULL,
    value                      character varying(255),
    user_id                    character varying(36)                                                          NOT NULL,
    id                         character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash            bytea,
    long_value_hash_lower_case bytea,
    long_value                 text
);


ALTER TABLE public.user_attribute
    OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent
(
    id                      character varying(36) NOT NULL,
    client_id               character varying(255),
    user_id                 character varying(36) NOT NULL,
    created_date            bigint,
    last_updated_date       bigint,
    client_storage_provider character varying(36),
    external_client_id      character varying(255)
);


ALTER TABLE public.user_consent
    OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope
(
    user_consent_id character varying(36) NOT NULL,
    scope_id        character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope
    OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity
(
    id                          character varying(36) NOT NULL,
    email                       character varying(255),
    email_constraint            character varying(255),
    email_verified              boolean DEFAULT false NOT NULL,
    enabled                     boolean DEFAULT false NOT NULL,
    federation_link             character varying(255),
    first_name                  character varying(255),
    last_name                   character varying(255),
    realm_id                    character varying(255),
    username                    character varying(255),
    created_timestamp           bigint,
    service_account_client_link character varying(255),
    not_before                  integer DEFAULT 0     NOT NULL
);


ALTER TABLE public.user_entity
    OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config
(
    user_federation_provider_id character varying(36)  NOT NULL,
    value                       character varying(255),
    name                        character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config
    OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper
(
    id                     character varying(36)  NOT NULL,
    name                   character varying(255) NOT NULL,
    federation_provider_id character varying(36)  NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id               character varying(36)  NOT NULL
);


ALTER TABLE public.user_federation_mapper
    OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config
(
    user_federation_mapper_id character varying(36)  NOT NULL,
    value                     character varying(255),
    name                      character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config
    OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider
(
    id                  character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name        character varying(255),
    full_sync_period    integer,
    last_sync           integer,
    priority            integer,
    provider_name       character varying(255),
    realm_id            character varying(36)
);


ALTER TABLE public.user_federation_provider
    OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership
(
    group_id character varying(36) NOT NULL,
    user_id  character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership
    OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action
(
    user_id         character varying(36)                                 NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action
    OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping
(
    role_id character varying(255) NOT NULL,
    user_id character varying(36)  NOT NULL
);


ALTER TABLE public.user_role_mapping
    OWNER TO postgres;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session
(
    id                   character varying(36) NOT NULL,
    auth_method          character varying(255),
    ip_address           character varying(255),
    last_session_refresh integer,
    login_username       character varying(255),
    realm_id             character varying(255),
    remember_me          boolean DEFAULT false NOT NULL,
    started              integer,
    user_id              character varying(255),
    user_session_state   integer,
    broker_session_id    character varying(255),
    broker_user_id       character varying(255)
);


ALTER TABLE public.user_session
    OWNER TO postgres;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note
(
    user_session character varying(36)  NOT NULL,
    name         character varying(255) NOT NULL,
    value        character varying(2048)
);


ALTER TABLE public.user_session_note
    OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure
(
    realm_id                character varying(36)  NOT NULL,
    username                character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure            bigint,
    last_ip_failure         character varying(255),
    num_failures            integer
);


ALTER TABLE public.username_login_failure
    OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins
(
    client_id character varying(36)  NOT NULL,
    value     character varying(255) NOT NULL
);


ALTER TABLE public.web_origins
    OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('2280ef32-211c-461b-a3db-ac56b7eef25e', NULL, 'auth-cookie', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '7e6c375e-f21b-454b-a278-677c87d98a41', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('5f5ef596-5dfc-4687-b375-870286567cdd', NULL, 'auth-spnego', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '7e6c375e-f21b-454b-a278-677c87d98a41', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('27a7a456-4a5e-4a65-8daa-ae8b9ab72fbd', NULL, 'identity-provider-redirector',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '7e6c375e-f21b-454b-a278-677c87d98a41', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('86a4fa89-3f56-45b2-b5dd-8b1b2d593593', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '7e6c375e-f21b-454b-a278-677c87d98a41', 2, 30, true, '84ef86be-8182-4222-894a-e388d513c199', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('40853a9f-300c-4fdb-880d-82fdf4f4ea4b', NULL, 'auth-username-password-form',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '84ef86be-8182-4222-894a-e388d513c199', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('67a563f8-ecf4-4929-b01e-8a47d180ef3b', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '84ef86be-8182-4222-894a-e388d513c199', 1, 20, true, '322641bf-96ba-4689-a97b-775dd020d695', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('fc66faec-d609-4fe1-934b-6413e3b3864f', NULL, 'conditional-user-configured',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '322641bf-96ba-4689-a97b-775dd020d695', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('48c1a72b-a66a-41db-8432-6f1573cbc259', NULL, 'auth-otp-form', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '322641bf-96ba-4689-a97b-775dd020d695', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('03cd8415-0717-4ae6-9f08-c07878fac669', NULL, 'direct-grant-validate-username',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '3b1ce050-d5b3-4af1-967c-3ddc064c12d5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('674e8e70-68f0-48cc-b5e4-7b396f6ea4df', NULL, 'direct-grant-validate-password',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '3b1ce050-d5b3-4af1-967c-3ddc064c12d5', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('3b6430bc-2862-4eaa-8ef5-af2379ad6f4d', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '3b1ce050-d5b3-4af1-967c-3ddc064c12d5', 1, 30, true, 'e31757e4-5227-4af0-9abc-88f451e3bfa0', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('7c9e491d-cb50-4594-985b-43a3170bbf9a', NULL, 'conditional-user-configured',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e31757e4-5227-4af0-9abc-88f451e3bfa0', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('8747408f-dd00-4758-af45-0ae2814bd8a3', NULL, 'direct-grant-validate-otp',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e31757e4-5227-4af0-9abc-88f451e3bfa0', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('d203fef4-35b8-4832-a6af-1dba35e903c4', NULL, 'registration-page-form', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'ae495559-9b15-4b9b-bacc-0b7e09940df7', 0, 10, true, '56e310a5-8ce0-4267-870b-890dec9ccbb1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('b4e710f9-1cf4-45ed-a052-46533fdc411c', NULL, 'registration-user-creation',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '56e310a5-8ce0-4267-870b-890dec9ccbb1', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('00131eb4-e0ce-4fe0-b16a-b3447bdb5c89', NULL, 'registration-password-action',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '56e310a5-8ce0-4267-870b-890dec9ccbb1', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('098c73d7-5dd3-4524-af29-7b5a58d8e70f', NULL, 'registration-recaptcha-action',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '56e310a5-8ce0-4267-870b-890dec9ccbb1', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('ad1dbe57-9ecb-4c7f-97d4-f62616f6c44e', NULL, 'registration-terms-and-conditions',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '56e310a5-8ce0-4267-870b-890dec9ccbb1', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('666eae66-3253-4a51-be7d-db9ce7ead699', NULL, 'reset-credentials-choose-user',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '054ee24d-9b9a-4e79-9044-a51d8fb4dfa1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('30833236-39a4-4ad5-9424-4a4d3d866dfa', NULL, 'reset-credential-email', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '054ee24d-9b9a-4e79-9044-a51d8fb4dfa1', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('27240c50-3ac6-42e6-bd09-31b6882fab9a', NULL, 'reset-password', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '054ee24d-9b9a-4e79-9044-a51d8fb4dfa1', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('713aab66-a852-4252-af5b-ed4e9d0e0dea', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '054ee24d-9b9a-4e79-9044-a51d8fb4dfa1', 1, 40, true, 'e6d597e0-d464-4d1c-aced-fa4a7803ea18', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('ecf164c0-cfb1-4410-855b-d53a85a1457b', NULL, 'conditional-user-configured',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e6d597e0-d464-4d1c-aced-fa4a7803ea18', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('fc7199e1-3e08-43f7-879b-6e3c87d4af2d', NULL, 'reset-otp', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'e6d597e0-d464-4d1c-aced-fa4a7803ea18', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('17589236-f979-4f2d-8592-1e081402db64', NULL, 'client-secret', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '54b6df09-cacb-4d5c-964f-13abcfe34996', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('c1e004d7-9dcd-4a6b-ae0d-136ba8b54125', NULL, 'client-jwt', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '54b6df09-cacb-4d5c-964f-13abcfe34996', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('488bf463-1f52-4369-ac1e-c1a9c6316ae2', NULL, 'client-secret-jwt', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '54b6df09-cacb-4d5c-964f-13abcfe34996', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('04d55946-260f-41d2-a78c-a106f06396fe', NULL, 'client-x509', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '54b6df09-cacb-4d5c-964f-13abcfe34996', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('1c688cb1-9aaa-4344-b47f-104a5518dff5', NULL, 'idp-review-profile', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'faa8df37-6190-46a8-80f4-5632bc694ffe', 0, 10, false, NULL, 'fe69ec04-2db6-4562-9764-a5f2e4a1a0fe');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('d82ec686-eb01-41a8-b14a-766e524022a4', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'faa8df37-6190-46a8-80f4-5632bc694ffe', 0, 20, true, 'aa19b306-97d7-416b-b81a-cc51a99edecb', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('99bd82fd-06a0-4172-b50d-2213dcb35354', NULL, 'idp-create-user-if-unique',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'aa19b306-97d7-416b-b81a-cc51a99edecb', 2, 10, false, NULL,
        '43adf230-1968-4600-b0b3-2f12df60d8aa');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('25ea45fd-1494-4834-aa13-638dc2097b5e', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'aa19b306-97d7-416b-b81a-cc51a99edecb', 2, 20, true, '0bb3f61d-faa4-4ccd-ac47-5e46b0a6bd44', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('799e6944-a1a2-4fd7-bea4-ae760b1e71d7', NULL, 'idp-confirm-link', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '0bb3f61d-faa4-4ccd-ac47-5e46b0a6bd44', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('22e4ee50-3baf-4e25-a28b-b2d97332db5d', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '0bb3f61d-faa4-4ccd-ac47-5e46b0a6bd44', 0, 20, true, '55f53e50-1d12-424f-ae2f-6f8ca3509c9f', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('0534cfb1-76bb-4db4-94d2-64a783204ad3', NULL, 'idp-email-verification', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '55f53e50-1d12-424f-ae2f-6f8ca3509c9f', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('0d350363-c84d-4140-b41c-11009d0c494c', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '55f53e50-1d12-424f-ae2f-6f8ca3509c9f', 2, 20, true, '5b4a5c48-8e47-4fa2-b96a-2df538140d0d', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('d572db91-c359-41c9-8ca1-a3054789b5d6', NULL, 'idp-username-password-form',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '5b4a5c48-8e47-4fa2-b96a-2df538140d0d', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('95841efc-5ef9-4fc7-9da8-32c171c98770', NULL, NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '5b4a5c48-8e47-4fa2-b96a-2df538140d0d', 1, 20, true, '649a161b-26a8-4526-86fc-82133c9fb620', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('895c92a3-fcc8-4d49-a155-cfb00f4244f9', NULL, 'conditional-user-configured',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '649a161b-26a8-4526-86fc-82133c9fb620', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('e05a5188-0f94-40ad-8f08-301dbf31b2a0', NULL, 'auth-otp-form', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '649a161b-26a8-4526-86fc-82133c9fb620', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('fc0f38d7-eff4-4f96-b91c-3f44bb9ed8d8', NULL, 'http-basic-authenticator',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '8d6bb592-b995-4671-ae6e-6c4431539e90', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('39a1c3b3-41c3-4d48-a975-cfc44a00496e', NULL, 'docker-http-basic-authenticator',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '580baf1f-ad44-46c6-ba90-533bcfdcae61', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('37e09197-a701-478d-af05-be1a77beefa5', NULL, 'auth-cookie', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '02219ebf-1959-432a-92ab-fc397f15ba93', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('6d1bf241-1d1e-49df-8de0-58ca9455a7c6', NULL, 'auth-spnego', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '02219ebf-1959-432a-92ab-fc397f15ba93', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('587c2d35-fd7e-44cd-9dcc-cf85ca3dc4bd', NULL, 'identity-provider-redirector',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', '02219ebf-1959-432a-92ab-fc397f15ba93', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('09a9250e-bc65-4892-8703-0d1ef3ceefe1', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '02219ebf-1959-432a-92ab-fc397f15ba93', 2, 30, true, '7b3bffbc-9c53-41d0-a17d-428cc0b6de4c', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('baecb258-1913-4838-8699-30cb530b2244', NULL, 'auth-username-password-form',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', '7b3bffbc-9c53-41d0-a17d-428cc0b6de4c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('7bc95e51-3021-4a8d-8a00-fac5e995352d', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '7b3bffbc-9c53-41d0-a17d-428cc0b6de4c', 1, 20, true, '6b55b6cd-cd37-4693-9eab-01a197af46c0', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('2a371072-8f1f-4bb7-a5e4-8fc5720f88bd', NULL, 'conditional-user-configured',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', '6b55b6cd-cd37-4693-9eab-01a197af46c0', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('f552b9b7-087c-41ec-8ea6-e42bc1102240', NULL, 'auth-otp-form', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '6b55b6cd-cd37-4693-9eab-01a197af46c0', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('3ffccdcf-fdf0-45c6-a3b9-15ca08e6b231', NULL, 'direct-grant-validate-username',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'c00ed738-1c0f-4a3c-b9b5-165595a7acb8', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('5a4c36ad-b576-4df5-888c-09a8c56ba410', NULL, 'direct-grant-validate-password',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'c00ed738-1c0f-4a3c-b9b5-165595a7acb8', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('8c31d9e4-83f4-4504-97ca-1384c985b199', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'c00ed738-1c0f-4a3c-b9b5-165595a7acb8', 1, 30, true, 'f192c80a-b470-49e3-97a5-637b5a2f6c98', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('70db798a-62a0-494a-b7b7-fe1d113837d5', NULL, 'conditional-user-configured',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'f192c80a-b470-49e3-97a5-637b5a2f6c98', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('3cd7bd6d-0415-472b-bc39-592e1ce12a5b', NULL, 'direct-grant-validate-otp',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'f192c80a-b470-49e3-97a5-637b5a2f6c98', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('b73bbaa3-51b6-4f6a-87ec-b43d8528c7b7', NULL, 'registration-page-form', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '7c0fd75f-79ba-4a87-9fcf-0c3bf8558d5b', 0, 10, true, 'ecd71f95-1a0a-490c-bd8b-0a845e586a17', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('ed5d2a77-2fa7-4ab4-b140-194bfead0876', NULL, 'registration-user-creation',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ecd71f95-1a0a-490c-bd8b-0a845e586a17', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('411c25ca-af92-4833-8bdc-210f659a2cc3', NULL, 'registration-password-action',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ecd71f95-1a0a-490c-bd8b-0a845e586a17', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('41f02ca7-cbe1-4824-b1ae-97dcbb020624', NULL, 'registration-recaptcha-action',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ecd71f95-1a0a-490c-bd8b-0a845e586a17', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('b5581513-a06e-4aea-9f69-1bcdcb4a0984', NULL, 'registration-terms-and-conditions',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ecd71f95-1a0a-490c-bd8b-0a845e586a17', 3, 70, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('959eba6a-70af-4a87-99f6-3c201b8b6806', NULL, 'reset-credentials-choose-user',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', '2061ffd4-8c0b-4d1d-9bf1-30c43fd8e4b4', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('9a8f78be-1db1-4703-9f45-88b98eeced3d', NULL, 'reset-credential-email', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '2061ffd4-8c0b-4d1d-9bf1-30c43fd8e4b4', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('853187b9-e819-4c6b-8a56-c5327f6aeda9', NULL, 'reset-password', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '2061ffd4-8c0b-4d1d-9bf1-30c43fd8e4b4', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('0bfeb9e9-d18f-4b77-b56d-5b67fe3e1287', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '2061ffd4-8c0b-4d1d-9bf1-30c43fd8e4b4', 1, 40, true, '49d85ca1-6a76-4a20-8462-92fd0e958010', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('1326c76e-2957-4f92-9568-afbcca10e2f5', NULL, 'conditional-user-configured',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', '49d85ca1-6a76-4a20-8462-92fd0e958010', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('2a220504-1c27-4648-b0ad-f23d31bcd1a4', NULL, 'reset-otp', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '49d85ca1-6a76-4a20-8462-92fd0e958010', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('a1553b38-ad50-4b4b-81fe-e044b54f3976', NULL, 'client-secret', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'a24b1aed-e154-4ed1-9c5f-cdfa3bdd5be6', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('9579985b-f963-441d-872a-926e61f5fb6e', NULL, 'client-jwt', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'a24b1aed-e154-4ed1-9c5f-cdfa3bdd5be6', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('ef416614-a696-46ad-91dc-874646acbf59', NULL, 'client-secret-jwt', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'a24b1aed-e154-4ed1-9c5f-cdfa3bdd5be6', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('81b9eeb1-6524-4127-b5d6-e35e01c9d330', NULL, 'client-x509', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'a24b1aed-e154-4ed1-9c5f-cdfa3bdd5be6', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('9cef85a5-6ff2-46a1-8168-7c28e1b01c81', NULL, 'idp-review-profile', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '53d3eaae-ccdf-4547-a79a-dddcb28def52', 0, 10, false, NULL, '6119b5af-b366-4c28-baab-8818d9e92d6d');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('ebf5d5e0-bbcd-4914-81ae-660d1149a7f8', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '53d3eaae-ccdf-4547-a79a-dddcb28def52', 0, 20, true, '8cd144c6-21f6-4ae2-8f0d-c4d13824abb2', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('c868ccfe-96dd-4948-a077-47698eaf3651', NULL, 'idp-create-user-if-unique',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', '8cd144c6-21f6-4ae2-8f0d-c4d13824abb2', 2, 10, false, NULL,
        'ad43d4b6-912d-478f-8465-4185ba0d7046');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('88ffc34f-ddc0-497f-9d88-c46d41923066', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '8cd144c6-21f6-4ae2-8f0d-c4d13824abb2', 2, 20, true, 'd2bfc0f9-3cfe-42b3-9d4a-7bda2e956c3c', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('63edcbc8-f7fb-454e-926a-5dc1796ca415', NULL, 'idp-confirm-link', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'd2bfc0f9-3cfe-42b3-9d4a-7bda2e956c3c', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('1d5a495e-1dc0-4c9a-aebf-a769cf40b123', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'd2bfc0f9-3cfe-42b3-9d4a-7bda2e956c3c', 0, 20, true, '00a9d7f5-ed84-495e-9c4c-49b4e38daea6', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('088a12b7-06b7-4a1d-a290-cb8fedf3857f', NULL, 'idp-email-verification', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '00a9d7f5-ed84-495e-9c4c-49b4e38daea6', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('756476c3-56c7-47cb-bc78-abe0a93211d6', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '00a9d7f5-ed84-495e-9c4c-49b4e38daea6', 2, 20, true, 'a7d09ada-659b-4a05-a0c3-0417e58fe926', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('acbeec3d-e59d-4952-bd8e-b70e83f7020e', NULL, 'idp-username-password-form',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'a7d09ada-659b-4a05-a0c3-0417e58fe926', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('8e93e2a8-f208-4f99-9196-0044ecec0b05', NULL, NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'a7d09ada-659b-4a05-a0c3-0417e58fe926', 1, 20, true, 'd7aa3c0c-485d-41c0-91c2-3231173d7378', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('c1ab42e2-11cb-4c84-bced-1c8715b9ee0e', NULL, 'conditional-user-configured',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'd7aa3c0c-485d-41c0-91c2-3231173d7378', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('aad6406a-8f2c-430b-b1a2-de848a2dc133', NULL, 'auth-otp-form', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'd7aa3c0c-485d-41c0-91c2-3231173d7378', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('97440e0c-fd87-4e3b-9fb9-24e9daec633c', NULL, 'http-basic-authenticator',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'e34f9c63-71fb-4415-88cf-bdaa557764bc', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority,
                                             authenticator_flow, auth_flow_id, auth_config)
VALUES ('687046a6-b215-408d-a179-915b0e4fb897', NULL, 'docker-http-basic-authenticator',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', '5de9d4b1-d165-45ce-914d-310058cf97d3', 0, 10, false, NULL, NULL);


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('7e6c375e-f21b-454b-a278-677c87d98a41', 'browser', 'browser based authentication',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('84ef86be-8182-4222-894a-e388d513c199', 'forms', 'Username, password, otp and other auth forms.',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('322641bf-96ba-4689-a97b-775dd020d695', 'Browser - Conditional OTP',
        'Flow to determine if the OTP is required for the authentication', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('3b1ce050-d5b3-4af1-967c-3ddc064c12d5', 'direct grant', 'OpenID Connect Resource Owner Grant',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('e31757e4-5227-4af0-9abc-88f451e3bfa0', 'Direct Grant - Conditional OTP',
        'Flow to determine if the OTP is required for the authentication', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('ae495559-9b15-4b9b-bacc-0b7e09940df7', 'registration', 'registration flow',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('56e310a5-8ce0-4267-870b-890dec9ccbb1', 'registration form', 'registration form',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('054ee24d-9b9a-4e79-9044-a51d8fb4dfa1', 'reset credentials',
        'Reset credentials for a user if they forgot their password or something',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('e6d597e0-d464-4d1c-aced-fa4a7803ea18', 'Reset - Conditional OTP',
        'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('54b6df09-cacb-4d5c-964f-13abcfe34996', 'clients', 'Base authentication for clients',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('faa8df37-6190-46a8-80f4-5632bc694ffe', 'first broker login',
        'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('aa19b306-97d7-416b-b81a-cc51a99edecb', 'User creation or linking',
        'Flow for the existing/non-existing user alternatives', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow',
        false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('0bb3f61d-faa4-4ccd-ac47-5e46b0a6bd44', 'Handle Existing Account',
        'Handle what to do if there is existing account with same email/username like authenticated identity provider',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('55f53e50-1d12-424f-ae2f-6f8ca3509c9f', 'Account verification options',
        'Method with which to verity the existing account', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', false,
        true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('5b4a5c48-8e47-4fa2-b96a-2df538140d0d', 'Verify Existing Account by Re-authentication',
        'Reauthentication of existing account', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('649a161b-26a8-4526-86fc-82133c9fb620', 'First broker login - Conditional OTP',
        'Flow to determine if the OTP is required for the authentication', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('8d6bb592-b995-4671-ae6e-6c4431539e90', 'saml ecp', 'SAML ECP Profile Authentication Flow',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('580baf1f-ad44-46c6-ba90-533bcfdcae61', 'docker auth', 'Used by Docker clients to authenticate against the IDP',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('02219ebf-1959-432a-92ab-fc397f15ba93', 'browser', 'browser based authentication',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('7b3bffbc-9c53-41d0-a17d-428cc0b6de4c', 'forms', 'Username, password, otp and other auth forms.',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('6b55b6cd-cd37-4693-9eab-01a197af46c0', 'Browser - Conditional OTP',
        'Flow to determine if the OTP is required for the authentication', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('c00ed738-1c0f-4a3c-b9b5-165595a7acb8', 'direct grant', 'OpenID Connect Resource Owner Grant',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('f192c80a-b470-49e3-97a5-637b5a2f6c98', 'Direct Grant - Conditional OTP',
        'Flow to determine if the OTP is required for the authentication', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('7c0fd75f-79ba-4a87-9fcf-0c3bf8558d5b', 'registration', 'registration flow',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('ecd71f95-1a0a-490c-bd8b-0a845e586a17', 'registration form', 'registration form',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('2061ffd4-8c0b-4d1d-9bf1-30c43fd8e4b4', 'reset credentials',
        'Reset credentials for a user if they forgot their password or something',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('49d85ca1-6a76-4a20-8462-92fd0e958010', 'Reset - Conditional OTP',
        'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('a24b1aed-e154-4ed1-9c5f-cdfa3bdd5be6', 'clients', 'Base authentication for clients',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('53d3eaae-ccdf-4547-a79a-dddcb28def52', 'first broker login',
        'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('8cd144c6-21f6-4ae2-8f0d-c4d13824abb2', 'User creation or linking',
        'Flow for the existing/non-existing user alternatives', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow',
        false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('d2bfc0f9-3cfe-42b3-9d4a-7bda2e956c3c', 'Handle Existing Account',
        'Handle what to do if there is existing account with same email/username like authenticated identity provider',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('00a9d7f5-ed84-495e-9c4c-49b4e38daea6', 'Account verification options',
        'Method with which to verity the existing account', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', false,
        true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('a7d09ada-659b-4a05-a0c3-0417e58fe926', 'Verify Existing Account by Re-authentication',
        'Reauthentication of existing account', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('d7aa3c0c-485d-41c0-91c2-3231173d7378', 'First broker login - Conditional OTP',
        'Flow to determine if the OTP is required for the authentication', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('e34f9c63-71fb-4415-88cf-bdaa557764bc', 'saml ecp', 'SAML ECP Profile Authentication Flow',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in)
VALUES ('5de9d4b1-d165-45ce-914d-310058cf97d3', 'docker auth', 'Used by Docker clients to authenticate against the IDP',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'basic-flow', true, true);


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config (id, alias, realm_id)
VALUES ('fe69ec04-2db6-4562-9764-a5f2e4a1a0fe', 'review profile config', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4');
INSERT INTO public.authenticator_config (id, alias, realm_id)
VALUES ('43adf230-1968-4600-b0b3-2f12df60d8aa', 'create unique user config', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4');
INSERT INTO public.authenticator_config (id, alias, realm_id)
VALUES ('6119b5af-b366-4c28-baab-8818d9e92d6d', 'review profile config', '620962b5-3bd3-421b-a251-19eb7e5a870e');
INSERT INTO public.authenticator_config (id, alias, realm_id)
VALUES ('ad43d4b6-912d-478f-8465-4185ba0d7046', 'create unique user config', '620962b5-3bd3-421b-a251-19eb7e5a870e');


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config_entry (authenticator_id, value, name)
VALUES ('43adf230-1968-4600-b0b3-2f12df60d8aa', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name)
VALUES ('fe69ec04-2db6-4562-9764-a5f2e4a1a0fe', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name)
VALUES ('6119b5af-b366-4c28-baab-8818d9e92d6d', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name)
VALUES ('ad43d4b6-912d-478f-8465-4185ba0d7046', 'false', 'require.password.update.after.registration');


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false,
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL,
        NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true, false, 'account', 0, true, NULL, '/realms/master/account/', false,
        NULL, false, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'openid-connect', 0, false, false, '${client_account}',
        false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', true, false, 'account-console', 0, true, NULL,
        '/realms/master/account/', false, NULL, false, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'openid-connect', 0,
        false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false,
        false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false,
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'openid-connect', 0, false, false, '${client_broker}', false,
        'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', true, false, 'security-admin-console', 0, true, NULL,
        '/admin/master/console/', false, NULL, false, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'openid-connect', 0,
        false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true,
        false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false,
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'openid-connect', 0, false, false, '${client_admin-cli}', false,
        'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('63c5d382-f272-40df-8399-a911e949c9aa', true, false, 'dms-realm', 0, false, NULL, NULL, true, NULL, false,
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL, 0, false, false, 'dms Realm', false, 'client-secret', NULL, NULL,
        NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL,
        false, '620962b5-3bd3-421b-a251-19eb7e5a870e', 'openid-connect', 0, false, false, '${client_realm-management}',
        false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true, false, 'account', 0, true, NULL, '/realms/dms/account/', false,
        NULL, false, '620962b5-3bd3-421b-a251-19eb7e5a870e', 'openid-connect', 0, false, false, '${client_account}',
        false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', true, false, 'account-console', 0, true, NULL, '/realms/dms/account/',
        false, NULL, false, '620962b5-3bd3-421b-a251-19eb7e5a870e', 'openid-connect', 0, false, false,
        '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false,
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'openid-connect', 0, false, false, '${client_broker}', false,
        'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', true, false, 'security-admin-console', 0, true, NULL,
        '/admin/dms/console/', false, NULL, false, '620962b5-3bd3-421b-a251-19eb7e5a870e', 'openid-connect', 0, false,
        false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false,
        false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false,
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'openid-connect', 0, false, false, '${client_admin-cli}', false,
        'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url,
                           bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout,
                           frontchannel_logout, consent_required, name, service_accounts_enabled,
                           client_authenticator_type, root_url, description, registration_token, standard_flow_enabled,
                           implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', true, true, 'dms-app', 0, false, 'MVbfUlSGRxzwMcBsdb50nwAeoQ3vxm7g', '',
        false, '', false, '620962b5-3bd3-421b-a251-19eb7e5a870e', 'openid-connect', -1, true, false, '', true,
        'client-secret', '', '', NULL, true, false, true, false);


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', 'post.logout.redirect.uris', '+');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', 'pkce.code.challenge.method', 'S256');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'client.secret.creation.time', '1746398207');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'oauth2.device.authorization.grant.enabled', 'false');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'oidc.ciba.grant.enabled', 'false');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'backchannel.logout.session.required', 'true');
INSERT INTO public.client_attributes (client_id, name, value)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'backchannel.logout.revoke.offline.tokens', 'false');


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', 'offline_access', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('7c162f5f-3729-4cfb-9cc4-77e6ec9dbb01', 'role_list', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'SAML role list',
        'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('cc457349-d42c-4c3b-96f1-a672dee20fb0', 'profile', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('7cdc7a4e-1694-4859-b8f2-0025e6e8a088', 'email', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('a0d9a989-aeae-459d-b12f-86258f0e7513', 'address', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('ce929fa8-923c-4c11-94c2-7a0c6d34e17b', 'phone', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('3912870a-6454-4381-875c-280f06306038', 'roles', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('2241a6ab-6941-4593-ab15-c3466042e3ff', 'web-origins', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('311098a8-67f5-4814-86a5-9364da34bf85', 'microprofile-jwt', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('f3735d70-e972-4254-af4f-cbf7c57556aa', 'acr', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('820650ee-3e6a-4412-b376-3f2ca1267cfd', 'basic', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'OpenID Connect scope for add all basic claims to the token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('908c630f-01fe-4258-87f4-1036ae43b8de', 'offline_access', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('d6f685bb-53c8-4497-a67c-4b52e121ef73', 'role_list', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'SAML role list',
        'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('6a315622-937a-4e9c-b2a8-d20fb74a7722', 'profile', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('dcba5777-e488-4320-9f37-fc2aad5e8e77', 'email', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('f16cde5d-f859-47ab-abc3-b54049f001f0', 'address', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', 'phone', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('f9c67dc0-6a3d-426e-8086-b7c2181c1187', 'roles', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', 'web-origins', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('84286307-9f7d-434b-9d61-0bcdccb02446', 'microprofile-jwt', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('7e4b35e7-a2c6-4937-af85-a16191edc053', 'acr', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect scope for add acr (authentication context class reference) to the token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol)
VALUES ('c18c446e-df26-4c0c-927b-ad3984b4f37e', 'basic', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'OpenID Connect scope for add all basic claims to the token', 'openid-connect');


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('7c162f5f-3729-4cfb-9cc4-77e6ec9dbb01', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('7c162f5f-3729-4cfb-9cc4-77e6ec9dbb01', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('cc457349-d42c-4c3b-96f1-a672dee20fb0', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('cc457349-d42c-4c3b-96f1-a672dee20fb0', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('cc457349-d42c-4c3b-96f1-a672dee20fb0', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('7cdc7a4e-1694-4859-b8f2-0025e6e8a088', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('7cdc7a4e-1694-4859-b8f2-0025e6e8a088', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('7cdc7a4e-1694-4859-b8f2-0025e6e8a088', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('a0d9a989-aeae-459d-b12f-86258f0e7513', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('a0d9a989-aeae-459d-b12f-86258f0e7513', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('a0d9a989-aeae-459d-b12f-86258f0e7513', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('ce929fa8-923c-4c11-94c2-7a0c6d34e17b', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('ce929fa8-923c-4c11-94c2-7a0c6d34e17b', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('ce929fa8-923c-4c11-94c2-7a0c6d34e17b', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('3912870a-6454-4381-875c-280f06306038', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('3912870a-6454-4381-875c-280f06306038', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('3912870a-6454-4381-875c-280f06306038', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('2241a6ab-6941-4593-ab15-c3466042e3ff', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('2241a6ab-6941-4593-ab15-c3466042e3ff', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('2241a6ab-6941-4593-ab15-c3466042e3ff', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('311098a8-67f5-4814-86a5-9364da34bf85', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('311098a8-67f5-4814-86a5-9364da34bf85', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f3735d70-e972-4254-af4f-cbf7c57556aa', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f3735d70-e972-4254-af4f-cbf7c57556aa', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('820650ee-3e6a-4412-b376-3f2ca1267cfd', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('820650ee-3e6a-4412-b376-3f2ca1267cfd', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('908c630f-01fe-4258-87f4-1036ae43b8de', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('908c630f-01fe-4258-87f4-1036ae43b8de', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('d6f685bb-53c8-4497-a67c-4b52e121ef73', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('d6f685bb-53c8-4497-a67c-4b52e121ef73', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('6a315622-937a-4e9c-b2a8-d20fb74a7722', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('6a315622-937a-4e9c-b2a8-d20fb74a7722', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('6a315622-937a-4e9c-b2a8-d20fb74a7722', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('dcba5777-e488-4320-9f37-fc2aad5e8e77', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('dcba5777-e488-4320-9f37-fc2aad5e8e77', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('dcba5777-e488-4320-9f37-fc2aad5e8e77', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f16cde5d-f859-47ab-abc3-b54049f001f0', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f16cde5d-f859-47ab-abc3-b54049f001f0', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f16cde5d-f859-47ab-abc3-b54049f001f0', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f9c67dc0-6a3d-426e-8086-b7c2181c1187', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f9c67dc0-6a3d-426e-8086-b7c2181c1187', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('f9c67dc0-6a3d-426e-8086-b7c2181c1187', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('84286307-9f7d-434b-9d61-0bcdccb02446', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('84286307-9f7d-434b-9d61-0bcdccb02446', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('7e4b35e7-a2c6-4937-af85-a16191edc053', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('7e4b35e7-a2c6-4937-af85-a16191edc053', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('c18c446e-df26-4c0c-927b-ad3984b4f37e', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name)
VALUES ('c18c446e-df26-4c0c-927b-ad3984b4f37e', 'false', 'include.in.token.scope');


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', '3912870a-6454-4381-875c-280f06306038', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', '820650ee-3e6a-4412-b376-3f2ca1267cfd', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', 'f3735d70-e972-4254-af4f-cbf7c57556aa', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', '7cdc7a4e-1694-4859-b8f2-0025e6e8a088', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', 'cc457349-d42c-4c3b-96f1-a672dee20fb0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', '2241a6ab-6941-4593-ab15-c3466042e3ff', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', 'c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', '311098a8-67f5-4814-86a5-9364da34bf85', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', 'a0d9a989-aeae-459d-b12f-86258f0e7513', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', '3912870a-6454-4381-875c-280f06306038', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', '820650ee-3e6a-4412-b376-3f2ca1267cfd', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'f3735d70-e972-4254-af4f-cbf7c57556aa', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', '7cdc7a4e-1694-4859-b8f2-0025e6e8a088', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'cc457349-d42c-4c3b-96f1-a672dee20fb0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', '2241a6ab-6941-4593-ab15-c3466042e3ff', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', '311098a8-67f5-4814-86a5-9364da34bf85', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'a0d9a989-aeae-459d-b12f-86258f0e7513', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', '3912870a-6454-4381-875c-280f06306038', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', '820650ee-3e6a-4412-b376-3f2ca1267cfd', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', 'f3735d70-e972-4254-af4f-cbf7c57556aa', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', '7cdc7a4e-1694-4859-b8f2-0025e6e8a088', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', 'cc457349-d42c-4c3b-96f1-a672dee20fb0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', '2241a6ab-6941-4593-ab15-c3466042e3ff', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', 'c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', '311098a8-67f5-4814-86a5-9364da34bf85', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('d9f9d564-3d1e-4655-bf92-43439800d19f', 'a0d9a989-aeae-459d-b12f-86258f0e7513', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', '3912870a-6454-4381-875c-280f06306038', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', '820650ee-3e6a-4412-b376-3f2ca1267cfd', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', 'f3735d70-e972-4254-af4f-cbf7c57556aa', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', '7cdc7a4e-1694-4859-b8f2-0025e6e8a088', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', 'cc457349-d42c-4c3b-96f1-a672dee20fb0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', '2241a6ab-6941-4593-ab15-c3466042e3ff', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', 'c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', '311098a8-67f5-4814-86a5-9364da34bf85', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('874da0a8-b38c-4fe6-854b-d2560708ab0e', 'a0d9a989-aeae-459d-b12f-86258f0e7513', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', '3912870a-6454-4381-875c-280f06306038', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', '820650ee-3e6a-4412-b376-3f2ca1267cfd', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', 'f3735d70-e972-4254-af4f-cbf7c57556aa', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', '7cdc7a4e-1694-4859-b8f2-0025e6e8a088', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', 'cc457349-d42c-4c3b-96f1-a672dee20fb0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', '2241a6ab-6941-4593-ab15-c3466042e3ff', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', 'c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', '311098a8-67f5-4814-86a5-9364da34bf85', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('f11d5027-2c04-4289-821a-5cd30dca6e66', 'a0d9a989-aeae-459d-b12f-86258f0e7513', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', '3912870a-6454-4381-875c-280f06306038', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', '820650ee-3e6a-4412-b376-3f2ca1267cfd', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', 'f3735d70-e972-4254-af4f-cbf7c57556aa', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', '7cdc7a4e-1694-4859-b8f2-0025e6e8a088', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', 'cc457349-d42c-4c3b-96f1-a672dee20fb0', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', '2241a6ab-6941-4593-ab15-c3466042e3ff', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', 'c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', '311098a8-67f5-4814-86a5-9364da34bf85', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', 'a0d9a989-aeae-459d-b12f-86258f0e7513', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', '84286307-9f7d-434b-9d61-0bcdccb02446', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', '84286307-9f7d-434b-9d61-0bcdccb02446', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('be111792-0c11-464b-9909-36b0f1137f46', '84286307-9f7d-434b-9d61-0bcdccb02446', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('33327f2b-7d91-4592-ac41-9575a07e0eb1', '84286307-9f7d-434b-9d61-0bcdccb02446', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', '84286307-9f7d-434b-9d61-0bcdccb02446', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '84286307-9f7d-434b-9d61-0bcdccb02446', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '84286307-9f7d-434b-9d61-0bcdccb02446', false);


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_role_mapping (scope_id, role_id)
VALUES ('c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', '805b73e9-feca-43ea-bcbc-caf8944aab18');
INSERT INTO public.client_scope_role_mapping (scope_id, role_id)
VALUES ('908c630f-01fe-4258-87f4-1036ae43b8de', 'b6506186-6087-4ce0-bac7-3acef5af4d25');


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('8e6c6713-ce5f-4fc6-bbc8-98299214cbf7', 'Trusted Hosts', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('102175c3-4389-46d4-92d5-76967aa3ca61', 'Consent Required', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('a6c5e2b4-940b-4fa2-acb0-69752deaa298', 'Full Scope Disabled', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'scope',
        'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('54451e29-9991-40f4-9824-9973a8aba6fb', 'Max Clients Limit', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'Allowed Protocol Mapper Types', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('23f041a9-263a-4928-aa76-b30b86bb334c', 'Allowed Client Scopes', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('9d5bd80f-6911-4779-95ba-170fcba5dd96', 'Allowed Protocol Mapper Types', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('b7a02f8b-144b-413b-a68c-b22ee9d1055c', 'Allowed Client Scopes', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('83dd46ed-1a91-470f-8e3c-da9f1d0053ed', 'rsa-generated', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'rsa-generated', 'org.keycloak.keys.KeyProvider', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('64221ab2-a655-45c7-8355-b0e84174457a', 'rsa-enc-generated', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('6d59429d-377a-462a-a4da-17244114b9d2', 'hmac-generated-hs512', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'hmac-generated', 'org.keycloak.keys.KeyProvider', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('33df132b-2b81-4a52-9af8-d564a1a98e4d', 'aes-generated', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'aes-generated', 'org.keycloak.keys.KeyProvider', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('d26dab95-3a70-4d06-8d23-c657cfb17887', NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'declarative-user-profile', 'org.keycloak.userprofile.UserProfileProvider',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('dcd1754d-36ee-4785-ab87-145473efcaf9', 'rsa-generated', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'rsa-generated', 'org.keycloak.keys.KeyProvider', '620962b5-3bd3-421b-a251-19eb7e5a870e', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('f3683d39-3e50-4ae3-896d-126b81f10a49', 'rsa-enc-generated', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', '620962b5-3bd3-421b-a251-19eb7e5a870e', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('67cbf2d0-6789-4f2d-bcb4-8b336a82c0c5', 'hmac-generated-hs512', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'hmac-generated', 'org.keycloak.keys.KeyProvider', '620962b5-3bd3-421b-a251-19eb7e5a870e', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('516951b1-6409-40e8-a2c1-cbdd1cdfb300', 'aes-generated', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'aes-generated', 'org.keycloak.keys.KeyProvider', '620962b5-3bd3-421b-a251-19eb7e5a870e', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('079cc5a1-76b9-4c58-8d98-d94e90c2b88b', 'Trusted Hosts', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('ff19e6c5-ea9c-42c3-84dd-a02b7dd132a6', 'Consent Required', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('d86253cb-a376-4102-9d42-374ed04495af', 'Full Scope Disabled', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'scope',
        'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('ae355142-0ea3-4031-b806-49edaced1411', 'Max Clients Limit', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'Allowed Protocol Mapper Types', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('81ff6e20-7689-4ad3-8385-6a7843aea9fa', 'Allowed Client Scopes', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('530a399a-d43a-4f6f-b31e-91f1f4658b45', 'Allowed Protocol Mapper Types', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type)
VALUES ('e59fc461-d722-444a-80e6-10b48f1792bc', 'Allowed Client Scopes', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'authenticated');


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('f6249c40-a6b5-4401-b3f3-6d13be5259d3', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('ea8b8702-d7f9-4226-b072-c4f7cf95c637', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('0f135721-06d9-4bb5-aeb2-a640caa0f443', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('98f4a8c4-4188-4667-b4ae-0a0c69f5d3e4', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('96d8f6df-7072-4155-bb01-9eec92c0ccd2', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('5de7e6d5-a0bb-465d-a51d-a832ed80b49d', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('2a43763c-17ad-41ff-8bbe-37d803d868b8', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('1aba28a0-4ba4-4f8a-a705-f308e4e0163f', '5b89b33c-aede-46eb-a211-aeeb0d1a66f6', 'allowed-protocol-mapper-types',
        'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('a0ff5059-c3c0-4754-92e1-7046c4c00ee8', 'b7a02f8b-144b-413b-a68c-b22ee9d1055c', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('6b5b586a-192a-4962-b73f-ea5e2816f3e4', '8e6c6713-ce5f-4fc6-bbc8-98299214cbf7', 'client-uris-must-match',
        'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('20578d32-fcf8-4312-9971-872ceb2958b4', '8e6c6713-ce5f-4fc6-bbc8-98299214cbf7',
        'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('87bb664c-5665-46da-84a3-1b2fb4a17904', '23f041a9-263a-4928-aa76-b30b86bb334c', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('7a6aca7f-4dca-493a-b358-7a9c0ef03846', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('bd7aec2f-d312-4d39-aeb5-5d24524a1cbe', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('f6fdf80e-926b-4055-aaff-c52b799acc45', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('f02a5830-4c4e-4a32-82ee-e58c5198648f', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('1540cdd3-358b-4e59-ae72-1ebad5bd3a1f', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('9c909a60-a353-4367-acd0-26cd52887159', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('2e4c065b-d73b-414d-b6c8-07389ab879b4', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('71f761a1-cfef-4407-9d2e-2f7bfcf76cec', '9d5bd80f-6911-4779-95ba-170fcba5dd96', 'allowed-protocol-mapper-types',
        'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('1806a71c-e3bd-4432-b08b-d0a3eedebf5d', '54451e29-9991-40f4-9824-9973a8aba6fb', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('a8e6a7cc-57a0-4a58-a3b2-5c47b6033280', '33df132b-2b81-4a52-9af8-d564a1a98e4d', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('d267c4bf-7b5f-421a-b353-c1256bf50724', '33df132b-2b81-4a52-9af8-d564a1a98e4d', 'secret',
        'xxycOMOjmk6bn8N8-GXk7A');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('689687ab-1bc7-4d3e-bd55-7b83b5682c8f', '33df132b-2b81-4a52-9af8-d564a1a98e4d', 'kid',
        '89c79da4-fcac-43b5-8404-28a7aa77ef7b');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('48f96030-2d24-4178-9d9f-53688f6c1c75', '64221ab2-a655-45c7-8355-b0e84174457a', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('a0b07fd7-307b-462e-9690-a8a1bc0a3cc8', '64221ab2-a655-45c7-8355-b0e84174457a', 'privateKey',
        'MIIEpQIBAAKCAQEA5NRYLO6IKQLlQ0zqrQFVRMMnvnQe/KUvHorQvES4Nr3sLzX2B5Vf9KseewT7SBwMQJ876QwWAN8EGAytfmO55y17Fh6JAqPhNNzDxivcgDOPIj2Uc4CFvRKGsMGi0BxcfwZqtHhUZRt7cIln8lUlddSrWXYnBOZQ8LfREXiYxtTv9OuHdwZM/f3Dl1gB9uQ4XXr8BYNeKGuOiLf5hIc1RtUdIpBhLtHQ517SiWb38NutGI7zwUMI0tLlYkofHbX6JCwmY4afv+RDN9JBCkZFGuHgKVvn08e4GQIzBzjD7wqqjamTGYNw/YcM1oANDKsXVE7wI0+U8J5arxlH3U7KowIDAQABAoIBACfmfN+M0jIwfpB/I3Z6QoeEbfQwJE0ScoZlVyNU6jglYr8Sri1BVyN/CQgTZMt8lIhaG6S1xkptmLWm1EOzGPHeBNXlCifrMnQ4wGxYLpEuLFmgmjePpAJFbjX49a5LG7fMgyOnzbN5mMsVMopXXXpP1Hb7eq9Ih7mJm8trl1wn5YvMJZ9Uk4NuLNIBxKj16Vn5OYVeJI5CxdEyc44IZXm7zCZMJVKtf15IxKOnidQ3kbYPgAmPxHm6d0cpZTKleJBCT9RA92//Zp49g2FLR+w+fIQC3bTf15EwLuXanrmvhijKOiIF/5u+iSD7TehQPKlvAmu+c+tl9pDCaVMZcbUCgYEA/+WDSE8xrRYU7geSwe3sSy6iGdq+Zj7MLlOUBl7dsHb8WVWp/C52AWWqzGBi1rPtqcB63q6Xe930F76SFmveGn2z6zIo/eYJvFcHzyNRjEf/YiOfP/QrZVUwd0PyjQJ5bR2BXTk6fZs+lv9M1k6nu4dLz7SxMNTzExRBKBLgXiUCgYEA5OwHrEyTpp18SlnTAzJu4seguLW8twbtqH/1GfKqNowYv3PHHlaCivMtkYDFuqoNenm7nT4icuzlgFlzuM7RDCh4yg+N6mmFm+7SoVTsm4hPZ8yxUL8PLiAntfW2Uvb00iABQUMQZ6U3oMM9xIigLIGUm/OckqP9DFXKT7hEtycCgYEAkyoxOBKjZQGAA+xDEFh+PjaRbwEH4tFWp4XVaVyBbgzfz5iea7NkliUb9vGvpf5QPgG+J/aMk+XvjQBCD7b1QpLsN+TfAjWbf78ldJDBQ0Xcr1oBKcyIcHxvpQdkpIe5wXDohu50nuv7MOeeDtmpSQXkKY2nIYg2StCpMBy7ACkCgYEAnTwZURkP2UMWWaM0sl9zlkRzeispwbT6i9/Ho9jvXKQBY47MV2QoKfQ5elUuerXOqC7w1GIXG0Tnpa7LM0aqg2VRAciJO1bbNG1nMvS3x2Rq1ercZ4+zh4UCgZKRdo61PZZKBl9f5zCt8rfntxP4oFkoj61V/8qvRkeuu+7fE8UCgYEAjmDPHVRmE8DsGUVGusBxbyHjo42Ge7quXzYQsMDjsLjoEB/EOQxCMu2alcGsuZ6aSCKNs9dzF6Se0L6oZucVdxYk1VWMshJptisH2zSlT9zZ1B/3k9cOtSPxxBi9Iks2d3ppqCsmAWRCemeaI8TDLEeanZ/eNlQ8yN8iB2rmWVE=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('1e4fedeb-6aef-4784-add5-377044c00f13', '64221ab2-a655-45c7-8355-b0e84174457a', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('c2ef4c45-a600-4910-9267-b020bf582674', '64221ab2-a655-45c7-8355-b0e84174457a', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('ce8edd58-69e8-4686-ba91-6f13460890f3', '64221ab2-a655-45c7-8355-b0e84174457a', 'certificate',
        'MIICmzCCAYMCBgGWnAqhSDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNTA0MTYwMjQ0WhcNMzUwNTA0MTYwNDI0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDk1Fgs7ogpAuVDTOqtAVVEwye+dB78pS8eitC8RLg2vewvNfYHlV/0qx57BPtIHAxAnzvpDBYA3wQYDK1+Y7nnLXsWHokCo+E03MPGK9yAM48iPZRzgIW9EoawwaLQHFx/Bmq0eFRlG3twiWfyVSV11KtZdicE5lDwt9EReJjG1O/064d3Bkz9/cOXWAH25DhdevwFg14oa46It/mEhzVG1R0ikGEu0dDnXtKJZvfw260YjvPBQwjS0uViSh8dtfokLCZjhp+/5EM30kEKRkUa4eApW+fTx7gZAjMHOMPvCqqNqZMZg3D9hwzWgA0MqxdUTvAjT5TwnlqvGUfdTsqjAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIXxZGHT6YXVx6OAz8F/qxbkwYK3kGgIM5XpiJK5jnBv1QhF3SPNBRKE3GBtfzmBqQtKNTwDJoVAjg/1jYgxz1mev5bAkAg2oaOOPfR7r0yCbbeihY2YW15P8NVTJru21TOL/wcOACkYAcbpAexXtl3cxqGByeH3Co370KPN6Qj/FQWE8vbLwhqRtbCBrobSiQ+RYFosA6b5Z/S1ikTEdYndhtAdbH821wF6aimUVa8AYu9b2ZcZVR0kZEQLrhDARK7TU+nK9KfWyC7y0caQqly+NiIY2oDTsRsUxEpOP0Upb6D9e14HsCvX8w8NJx8JRYmsR0GPEJRyIwrI8xvJjus=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('ff681baa-b78f-44e0-976c-6471f629c8e1', '83dd46ed-1a91-470f-8e3c-da9f1d0053ed', 'certificate',
        'MIICmzCCAYMCBgGWnAqgazANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNTA0MTYwMjQ0WhcNMzUwNTA0MTYwNDI0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC8f9d4V3MbvQpOfUGB2F7pWm99PlxhEHrkl8EfertM4e7Hlh6OSuC8o3l9pRzWaM96z88OloQ3QJAT4/DHSBtPyLM7S2NxXcRXLW9tHU6pSGCMJ2ocsqFfoX4cKZgF30+BXkCXO+AWnMnNDRCOv7HSfEJKUn4lvJ/tgn3HNkG7VFf4zoL0wo3hwj8LQmLaW30o9PLCLCQF8HuG7AB1GX1Hk0Qml9qj8cVcrww59OPbwp1AtaU5pg2tQDxDncYs25GG4N8pZvhESgm9zL820YNtEC+U64o+P2ZuTbIK68pLX/tD+z1YL23McmdrNtS+NiXlqAZovlE827GLvPnI8EptAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJt4cYbf2F+uMOR/WDy+xE/IM+t0XiNCTDPBCSiR8OZnY0Uub9G8RzXXRymdzPBqGP0NVq7Bq/qTJ6YRyc25xT8OPCbHtr3Gxzbo9eJVlQqYV6jOsWhGOcYDSBQiLQNAHZq1de1T78oWYW18Rgo1cVFQBB7DgGZMJv4CNP5h6ZVgcnDII3d6QHn166tSoqyatlHeUTm4FK5Pg0MT97q/n5/rjpa/lBHZSBcY/IKfpa9PjQSdM7D0QBktHvqlh/h5oK9DiOq8KUv5ZxD3nfpBbS4c2MOClfuOUjpntRux2WXcnxG0gkzwmOP2ZQ0X/dilob7ycRSX7gfhAzWv2Sf/LD8=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('cdb4bb63-4cc3-4302-8814-8d18c5a04974', '83dd46ed-1a91-470f-8e3c-da9f1d0053ed', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('3f77cf23-30a9-4348-9d35-84d7ecea283f', '83dd46ed-1a91-470f-8e3c-da9f1d0053ed', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('ceabe59d-2f39-4b93-918a-1f26c9dd0d69', '83dd46ed-1a91-470f-8e3c-da9f1d0053ed', 'privateKey',
        'MIIEogIBAAKCAQEAvH/XeFdzG70KTn1Bgdhe6VpvfT5cYRB65JfBH3q7TOHux5YejkrgvKN5faUc1mjPes/PDpaEN0CQE+Pwx0gbT8izO0tjcV3EVy1vbR1OqUhgjCdqHLKhX6F+HCmYBd9PgV5AlzvgFpzJzQ0Qjr+x0nxCSlJ+Jbyf7YJ9xzZBu1RX+M6C9MKN4cI/C0Ji2lt9KPTywiwkBfB7huwAdRl9R5NEJpfao/HFXK8MOfTj28KdQLWlOaYNrUA8Q53GLNuRhuDfKWb4REoJvcy/NtGDbRAvlOuKPj9mbk2yCuvKS1/7Q/s9WC9tzHJnazbUvjYl5agGaL5RPNuxi7z5yPBKbQIDAQABAoIBAC5z2M80yc6npv8Rug98GWOrYDc+o3heHdLwnOybi8XWFciEs7IAPOLv7FQs2O7ztFHBHXcsW5fcJsVoEmGh4O0n+hdeLDr3TxfmwANlSgnIptZTLkC1OrR88T2SeH7V+dtZNVSvsjkQWWDZW9+52OIUsidrrd+x3L2kv0dVFRzLL0ylquyXxZD4h6mMp7yYXYOrDIEn+3gQC5lGQHugA/ytV2HrSar5EhC5TfxoZG6jbzUhFR1m0jnMasgRabPfeavlqnYbx2kOgcBLMCjJdNLAeHODnuC2BtFV8LdTSvLyqw70ViQLpDp9XPWoX5+y4NanCNXMNvNqRZ3DX2Vx6XECgYEA6WJyiQI5EqIoosSG9zBkNZlKHL3Tbj0dmiZ5U0iRtozwzAKvC2lGI0TI9xUdxKW8WTWi8AqfLHnhp4w0GqEEUpejRjR4JihJU0gLQJLhVgZk1WHU3b4SpNcRkCv6QVYp3XHqWR3mbMUKDjp4p+2dhX2tNnaSKGYxtMLSfkv0/NUCgYEAzsPuX8kLUEvsLwHAevrX8tBWh73x6DahcmAwVBP2JPOhGOVf+aZltthvDgoR8HFE81x0dt26hhyOyEGCu+hkMwRE+Gwiw4uF6zkORvbobKyvoP1smGmOnoXXpQpyN1h93ZEmeJQBNgAlfXcBMC6Xjln8Q0mpJ+Kq4/QuYI93gzkCgYAOcLfzgD61x3DKOWy8aLMameR7CMfHP2LQgebp30icyfWwOc5I33emgQAKQbU40KRpxKbTQWT95ICw1Dz5FNNmpNlGY8K3YbC/xWpk0XG91+FvToFUQwl2R5Rfnkj6t/EZMY41e2MhgcOQg8+pXEtt0gvgnc+HTmNu8ssBY4PCDQKBgHKJdvL4m5vPcvZXMhjt+9I2NrjbL7ZDDQwe3Ka2qBOwIf14ksHou0+edWaBjY50MI3fGWT/TuQbzbyBDbqp8VeRdeNng5pvH7A92vrUq8wHnQLBX/bOAoMuAVcbgknGa3LhhT4mPsV7L0lhMvdN2AazMlrT4zCFD8VW7pnu33WBAoGAYgf7FuZXz8AQf0JEMCjVHXONoH5mKOEE1lHVXHhPudBiwqMkyaMP9bQtAdZawT8st1SyBDCTl8fPmF5tzoQcgedvoppuCT1TKJ7vLxM0la+JAKq7DdyPXafQMRB0htFHMxJ6KN1Mynal0JWbeNmcuW4mjyqjUf3TRMDWQiVub2o=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('7dfee59a-9323-4b0c-92d1-5cc0b44e4295', '6d59429d-377a-462a-a4da-17244114b9d2', 'secret',
        'I_z4tAsUPbBh-RJR6Jm_6VdtxXwvyct0cqMaju_RDaVIOM0EVSYJzZM7BDWLOIHrh8ayJcxfQHVK0Sc5wFbs5gH4mYPFGoa4-jluFdU_SqV9inTu3xsFSCiRv5gf6shQN1jLCellbyEs2IQAYdkx1LCDNSEncu7lnyGOPQeL0Kc');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('12b08ae3-54c6-4c76-a096-77e26034d53f', '6d59429d-377a-462a-a4da-17244114b9d2', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('33544acc-a4cc-4fab-9d5c-cd6ae286c92e', '6d59429d-377a-462a-a4da-17244114b9d2', 'kid',
        'c9030521-e121-4971-b80b-417e2fc0c0e7');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('f20419ed-cc54-4733-8cb0-f38b5d2878b1', '6d59429d-377a-462a-a4da-17244114b9d2', 'algorithm', 'HS512');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('07bd263d-5552-4019-b550-c26da5a83ae5', 'd26dab95-3a70-4d06-8d23-c657cfb17887', 'kc.user.profile.config',
        '{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('5f6c3538-8983-4ad7-9007-be48e3380140', 'f3683d39-3e50-4ae3-896d-126b81f10a49', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('01c44b36-3bb7-420c-925b-f9a4b475bbe1', 'f3683d39-3e50-4ae3-896d-126b81f10a49', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('58e3810a-5edf-4e1c-9eeb-ca9389a68cc4', 'f3683d39-3e50-4ae3-896d-126b81f10a49', 'privateKey',
        'MIIEpQIBAAKCAQEArRgOZOvK1alp/rwyBdZKVExRrPxSGV5JdKzKRa9xgRxYL18Nm81KFx4QmxrqXGYsycaG/U7PmDB8tJHCZyaTdCaYo1+meDcTewAUII8KI0/y0PLeiw76Ue/q37+UOz0OPPXySJ5s8u+JK/pqaSxwBj4MlK5kxZzqkhCbfHBeGfu40plIRoIiyf1zWh/ULI4aW9Fcy7MxGG1C+2VpRqsDgv0Zjuo2lkWWUzhmUfxQ0kJ2jvEGeO+10rt9I9EO7P3mXBx7R6oUmI0pIOaT0vpZkpK3shrVI+DM2/lf8PzdM0XdOY0G7t4QyYsCVixen5wsoURNEm6w6TfWFNomExGE6wIDAQABAoIBAADPPH3/Vk8CgFLnKWq6klVrl/Qxp+ajeL95cWa7B9JdQhJSpPsmDiMmilhXW2I8Phhhe88id7kT/PlRNzIJTaY86fjVoS8tvsMUAIQYdyksHgwZHq5Szxvj/dq3CCfwxKjHU69AQm0ubptMjAPa59k3oBJv8Fu2PKibOEbwNZh0gXEiln3NhoIXBjB/zjfyXv6F4cFxLvDAPDY0hyGREugl3Mmv0tGWD0N3VcInyaCaYhII9qdkqdUjQ7g6SXKt/rAYWM3kmU1p+LYcxV4WuSA9rayQ565U3w3O5uUAsbP/PyWqkkwZAo1O/TXN1l8ODXh3qPRFklCi7V6SPRhtiIUCgYEA6xrojrQKuUCNi80XuZVlHdIa3cXCLsxCdNCPIroLTin26No6lX7TwVq6tvOfQKuu/rV293tINQ+gHUPsB4BXZg/wcy76kEdiH7sehoZgvNNGkC3T//BrSwyUoR/W0fep+Tfuujg9m06PyqGUREmPNq5eobLvQNZIoCn84UDIEEcCgYEAvHpGi07MWLxcCwdl4tYlRvZlqcRtI8MKrg994JJMn90vK6c6sQlY5n02FbFuXetD+cwVrCKOrMcztynOv5863cTVqy9RY7tulhCaIXZJQBDlfcJvjZc54iFImHnK1MhjZEmvCOr9dnebJlaXHwUYof2la/O7FbHYPJnBkRtDPD0CgYEAmasY3k1nxPYgjoQbQb4YPYma7eHYrmXr+hZnuDcKNKjRLhmVuSkQl40KBZLvQIH2+5z4iYIXDDeOXBKNL8n/VkKM03ydYbiGtl7D8QHcMQ+XS53ot50ZRBCRBU+eRdcvTin069reyahr6/H4yzmZVhBa4i3mm+Zzydwn4cNKAPkCgYEAjvmm1/iflVTV8dvb01alko5Jkp4aOL21NVM1Jw10KPVN2iySnke786TaSVx+n6pft3e0nQ7d8n1uYqzJVJ2Ct0ag26oacLB3dEkF0wp7CKmInXzIyL0GQN8Exf3l+sJEe4hVyksQmTSkMlIPc42XIRNb0Gdk7VEq+tWce+oVd/UCgYEA5kh8DO5n389zf9GsceH280m6zgVt0lfzKMB8pJ36sBPildeU9L3RVmo8RPn5mmspJ9/7nikLKtN3eL+2Y4W9Um1ieUFiunvqruOecqHeGw1YedDF+N4SAtQcCTM/5wqdYfYKUDbLWaIBv7JiZYDzXpL7F+493uS4xqGIwHYGLFw=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('5933a733-cff8-464e-bebf-e5ee44c12ce3', 'f3683d39-3e50-4ae3-896d-126b81f10a49', 'certificate',
        'MIIClTCCAX0CBgGWnA4+KTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANkbXMwHhcNMjUwNTA0MTYwNjQxWhcNMzUwNTA0MTYwODIxWjAOMQwwCgYDVQQDDANkbXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtGA5k68rVqWn+vDIF1kpUTFGs/FIZXkl0rMpFr3GBHFgvXw2bzUoXHhCbGupcZizJxob9Ts+YMHy0kcJnJpN0JpijX6Z4NxN7ABQgjwojT/LQ8t6LDvpR7+rfv5Q7PQ489fJInmzy74kr+mppLHAGPgyUrmTFnOqSEJt8cF4Z+7jSmUhGgiLJ/XNaH9Qsjhpb0VzLszEYbUL7ZWlGqwOC/RmO6jaWRZZTOGZR/FDSQnaO8QZ477XSu30j0Q7s/eZcHHtHqhSYjSkg5pPS+lmSkreyGtUj4Mzb+V/w/N0zRd05jQbu3hDJiwJWLF6fnCyhRE0SbrDpN9YU2iYTEYTrAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAELS3qGVI3wRSGO0nLcl/wHiXA8f6BIaNq8T4bXJbCY2GdE73t7CmxW8bDshefQS/HkAQo4fv4AX85Rbjrlui80rOn/W0h+X8jLrXn0EAS3unLyPrYkmT5NKf7P7TYBxI347YExVz2fEZ7qiZrkR9CHwUnsF9Pi50/5AbCt4jgeEBLcSMZ6Q4ELOr+Eg8hqZf+nrcITWzrxcAy/MOIfb+3vYK52A68MzGQ4BekePTtdbcPbg1If5YVhnygypZaVgbFjW7QyhmYbciSahjFvZjUfX8f0FMD0c70XWgdIrRpl+S3TukgDuJxXWslAJz79xRsdv6BKoJT0xSrWZ9ujhxio=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('57b79a5d-81d8-44e0-be27-96e989e0e81b', 'f3683d39-3e50-4ae3-896d-126b81f10a49', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('486d797e-4d1f-4859-970b-a2662d70a5e9', '516951b1-6409-40e8-a2c1-cbdd1cdfb300', 'secret',
        '4LuObbiXblJ98GHd6EefSA');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('6bdc83ad-b975-4396-882b-f244ae63eaca', '516951b1-6409-40e8-a2c1-cbdd1cdfb300', 'kid',
        '5a8ddc6c-cde9-4e02-a638-1ae268c9a0b9');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('3485c066-67dd-4391-b013-705680733076', '516951b1-6409-40e8-a2c1-cbdd1cdfb300', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('5c07397f-73e4-442f-b99b-d4805e48e4fc', '67cbf2d0-6789-4f2d-bcb4-8b336a82c0c5', 'kid',
        'e17a7956-a989-4497-9e49-040607dd26e8');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('fd4a28ea-de30-4fdb-bf87-e3f988ae0d07', '67cbf2d0-6789-4f2d-bcb4-8b336a82c0c5', 'secret',
        '6qf2PlQvCp-849x0M1mLH4UVpNOFebWQ8MdOPfBbw3FN7YrTAFd9e5WGOer-hLCcJhSBs4Z-4BICA5lvwmOP4oeN57PwhwSCW7We3w3UUIgWnlX8riKphJ593e29cOf1q_lcrd-ZdbtcTvV4ir6tRVfPkOR9_U7Bmf2duAJiH0c');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('4fb57cc8-8b10-40e4-af1b-ab2c843fca67', '67cbf2d0-6789-4f2d-bcb4-8b336a82c0c5', 'algorithm', 'HS512');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('0f787729-85d5-442b-8c8a-98437de7d4f3', '67cbf2d0-6789-4f2d-bcb4-8b336a82c0c5', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('baa30f8e-d297-45f5-aa26-f0d17923ce06', 'dcd1754d-36ee-4785-ab87-145473efcaf9', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('830c591a-48c7-4767-9d95-af415a9af7a5', 'dcd1754d-36ee-4785-ab87-145473efcaf9', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('7ab73fe3-4662-4350-befe-285a8fcb2788', 'dcd1754d-36ee-4785-ab87-145473efcaf9', 'privateKey',
        'MIIEogIBAAKCAQEAkXOygjwM9iZ1opOKs2JmcrPYehezcGir8MxFcTbjY1g3CZBkhMFjvTG9q3kXMkddaXm1HmApE7vHh4z3O0RGvsvUWQLY8FysFpbggKvv+SmY27J85o0xP2Kam6UtwCn+oJ6t9JNYERDH7JAaodqsyWXnSH9MegYew1uD+eXaMFNE8RPqA5+KFpNc8qGmPzxHYeHsoJhFjm7RyqYcgLVVxjt3pTtag1BxoMAEFo/Qn3vtLg4NrOCTFHzR9g3f0vBiMFyg10uLQn/Q/NcX4NmDmndaNyN5/Cl/YPQ2WCI9A8McE0578pH7XPzxFPmfdbrZPIT38AiEYy5eoHq2gHd6swIDAQABAoIBAApktQ2/UsHID8HVPyUAVAfAOCjJRsYyhI7JWfD0Fh2EMTKawcQGuaTMSBxXo8Ow+8jMrJeGEYlacrCJ7ySqBVAe6oaNwIi0ZouarmIjZxtr0INqZqhm0G0SE7AphnJjzdEWZaHDYZielVqfFXgZUx11DajNh950T4BwKqcRuJyZSxBjIBx8wl2pVqrDhcfWXjKmv+H8tfjwhB1mFIXq9O8VcyTGbPsyoS2qsycQfjaxyeBB8mbO9i+ZHwHbmPQOa3CMNRg3OWoA8s+nCa5yz5vRGosRsUfuqdZWOc1jvwZsLxJ7J1t1ARebxagcU/2YEADyTgaQrztIOiOAGYzCDkECgYEAw5Z+F1xDs455wpe+YG+bBxk+ZPvI4zQl5gJZi6LtMmSCdbB1ltaR5+WQpGw+n78ZLIGG3sTjVYbQaG6QBDTRC5P2FTjx0Qj0ulVk8DMyFLpMSUgjtaqJPnKAm2o9sb72aInUMuD4EQ8kwELm+FdDg7ABRRySI0HyiNLuQu7hEZMCgYEAvmDciH5P0c6wkmxC2nt9t2ZFQb2YjnyylkospTO+sGrUtfVXvELEv9WKZvLgyGZfHQ5/tm+mYHRKsPqHtULdYl2p28pIzSBukCSxjJCZfX3lEwBes8aPJ+T9rvU+Hl1/RHlywBj2G0BLd2aLyWYTUVbQ1WHF++P7om6UwgWcJmECgYBfrra+vN9N7wx3+v4idVbVES9p/ZcYN4G21T1zR2Bcv7jm1E2iXhQA61hoZ5/3TGiHUlJlltJUG+DGxhfkRuZhkJ/ZYANErOn0YiRAMft1EnKRgx4dGHGNwDxUS5Qk6XPoTk0mGtKgndTvzYrqwN4BhVAJvGFtqCx7bR0sV2p5ywKBgA8WiiPfLuBH60KPhfTe2KXSWybMqeyRAW5bzpIBOdmtfdI18ZAgEovJlsB1+06mnl8lKQYCb0MxtEG2eU7qT7VeCvo6W+615U1TOycSxrdlZOROoTLKR8o3octd8GBjtJRus6N51vdt7w01eVqq1lkZ8k8XAqPl+6lx7iQ6YZfBAoGAWoijID2u5L+o6S6I6AuHgHLOdVtz3MXokj4Wbh4sejZzZnYbO1QyEhln3xw8D5qI+p5bIGTJhwtBkpvYB5RHgW2Cho9XZW655m3480t7LxYzEXKrQ5dG7dq+zhvNYFM3dG3ohyRFzzH+FuuXANi+cYF7J339wklGw6qxpWRzaWE=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('0e17051e-1023-43d8-ab4d-a72ca7014811', 'dcd1754d-36ee-4785-ab87-145473efcaf9', 'certificate',
        'MIIClTCCAX0CBgGWnA49gDANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANkbXMwHhcNMjUwNTA0MTYwNjQxWhcNMzUwNTA0MTYwODIxWjAOMQwwCgYDVQQDDANkbXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCRc7KCPAz2JnWik4qzYmZys9h6F7NwaKvwzEVxNuNjWDcJkGSEwWO9Mb2reRcyR11pebUeYCkTu8eHjPc7REa+y9RZAtjwXKwWluCAq+/5KZjbsnzmjTE/YpqbpS3AKf6gnq30k1gREMfskBqh2qzJZedIf0x6Bh7DW4P55dowU0TxE+oDn4oWk1zyoaY/PEdh4eygmEWObtHKphyAtVXGO3elO1qDUHGgwAQWj9Cfe+0uDg2s4JMUfNH2Dd/S8GIwXKDXS4tCf9D81xfg2YOad1o3I3n8KX9g9DZYIj0DwxwTTnvykftc/PEU+Z91utk8hPfwCIRjLl6geraAd3qzAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGvwIPzVK2ONo3ARA8ghF38yPbZYckLW++4p0dhFXZtNdRalM2Lkm+TFClMCJkBBuGD0nI3HwiHztOH/5PjjCeAenkO210z0c1J6VdB5L2btY1ajBQnlIDKtBg4zrHTQwX4dcCVEG2TiKpNBjEwfwMEYPJr9pJR6eZ41nupH3DZwIdkEjHp6b7a1yBByGqllXORj45hybt7md7EYIKfEZJw5csevH/FEQqbNDTaMQPHu9NMyGVnVw2CC3z6Q4kAc/zVuVU0kmqYCoCs/IosKsdPyHgJ5/jV87hyNHP+5w8DqvuDqRPSRaITLQEUj/jqgUNCYf7osidMLKtihJUwEOHc=');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('12968570-8d72-4477-a786-8f063b94a587', '81ff6e20-7689-4ad3-8385-6a7843aea9fa', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('e3662456-cb1f-43f3-bf14-5097cc984fa7', '079cc5a1-76b9-4c58-8d98-d94e90c2b88b', 'client-uris-must-match',
        'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('7878cc1c-bcca-4a73-ac1f-cab2ae6a69b1', '079cc5a1-76b9-4c58-8d98-d94e90c2b88b',
        'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('50012d52-4f19-43f1-8706-36ab415b4c4e', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('5ac84cab-674e-4f5c-a629-cdd86af0548e', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('ec10935a-1133-4142-b794-310f957fbc1f', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('088352a8-826c-4d3d-8201-dd28d10d30bc', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('36bb83ea-3b5c-4cf7-9054-c4101c0673dc', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('3baa22bf-a7d5-446e-8843-7632b53e1749', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('a9b41ce4-1373-4cd5-bc1d-8f4af97fe6c7', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('b6cea501-6ec4-493b-90f7-d1a81bd69b88', '04ee6991-6f81-41a7-9bd3-881c7ec9ccd6', 'allowed-protocol-mapper-types',
        'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('3308421c-f40f-4777-b55d-1d0ed4124882', 'e59fc461-d722-444a-80e6-10b48f1792bc', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('e240f9b1-438e-469b-88b0-3fb5e7f4aaf8', 'ae355142-0ea3-4031-b806-49edaced1411', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('dbba46fa-bdcf-430c-8634-dddb01f44d63', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('76b9bbde-ef6d-4e39-97e5-5fa92b70f777', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('1bfa2225-3513-440e-8a4c-01eb9414e91d', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('550d5d2f-ce66-4f36-81b3-7eb8c5dfc203', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('a339bf3d-43c8-4c78-b02c-c26a13145776', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('9f44bf8c-d852-4a65-bdef-cb9434665221', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('70fbe093-d09d-498f-a9f4-c19c0c3c2e09', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value)
VALUES ('e0baeff7-d8a2-48e5-a43a-fca29b906a00', '530a399a-d43a-4f6f-b31e-91f1f4658b45', 'allowed-protocol-mapper-types',
        'saml-user-attribute-mapper');


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'af87e5e3-16ec-4436-b17d-25d2780f229c');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'f3b12638-a018-4eda-af5f-0e677e1f2fa3');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'df7f8af1-30f4-4cce-905a-bb8b97aa73bb');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '9afff77f-b753-4f99-bca0-d59391672fdf');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '8e852909-d143-4475-874b-9f27f5d7f885');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'a258c392-d537-4eca-8f4e-99c9d7849061');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'bed3c950-872b-4f62-a651-abd6ef85909d');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '30a35e8e-45e1-42f5-b956-667fff9c8267');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'cb948413-64fc-4121-b171-d22957eea549');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'f0799c04-f07b-4678-93e7-7992e3b312a1');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'd50a09ca-5072-4350-81f6-abd218aeb951');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '921c38fe-56cb-4208-a846-a0e64d23eaf9');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '65d0342f-f094-4a05-bb9c-b120b60b5ed2');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '8090370d-dce8-413a-99d3-f7836451cddb');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '58b60710-606f-40a6-ac4f-f34397babf19');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'ebcbe6e7-a7c0-43c9-b3d0-9ff29433d286');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'c6a303de-90b7-4a42-9ea2-5aa65b30b72b');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '90b64bc6-a509-42b1-a534-c9ea6a7a3395');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('3755f040-41d7-49e4-847b-ac896c124262', '5c0fd52f-aea2-464f-9b8d-c82b5ba5d362');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('8e852909-d143-4475-874b-9f27f5d7f885', 'ebcbe6e7-a7c0-43c9-b3d0-9ff29433d286');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('9afff77f-b753-4f99-bca0-d59391672fdf', '58b60710-606f-40a6-ac4f-f34397babf19');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('9afff77f-b753-4f99-bca0-d59391672fdf', '90b64bc6-a509-42b1-a534-c9ea6a7a3395');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('3755f040-41d7-49e4-847b-ac896c124262', 'cd410a61-b616-4d96-8c38-08776a5c0e4c');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('cd410a61-b616-4d96-8c38-08776a5c0e4c', 'f0eb8bf5-c9cc-442d-96f7-fcdda071e8c4');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('c4d6d3ef-5387-4cd0-a461-6794543c2d99', '5f7cd433-0444-4a35-8e30-c3d17ff630c7');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '492c7bb1-a0d2-46d9-8b7b-27d587c7f078');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('3755f040-41d7-49e4-847b-ac896c124262', '805b73e9-feca-43ea-bcbc-caf8944aab18');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('3755f040-41d7-49e4-847b-ac896c124262', '95694cee-44fc-40e4-8951-517ce5dabce9');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '79d0b27e-b04e-4f8f-abbc-58c730a7ac18');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'f674c01d-4b2e-4446-8cc8-2503d615fddc');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '5fcf9430-8b9f-4503-a9bc-8636c7b19a30');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '62d2660c-b2c4-4243-a0ad-2ab2738873cb');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'f8b0b5d9-6a13-4959-9363-158db1816628');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '3f1ae63d-bdc9-4c76-a88d-09efb017c5c3');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'd3fee103-70ea-4f1b-a302-7e6c60d90be1');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'c4edd002-0e6d-450b-806c-6784a0022bed');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '4bdc51ef-eff6-4b7c-855b-c741f042b969');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'f306c0dc-4998-48c8-baef-ef9d51d4fa03');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'e1533655-40da-4f9b-961c-c337c9c4bd33');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '65cfa32e-f103-43ab-a0ac-db6e91c79091');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'e38ed989-0619-47a8-afaa-416920e40861');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'c2e878c1-013d-4d5e-bca9-22e0ea549a8d');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'cd17991a-c48e-43a5-8a89-2f25cb64e719');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '4fb31236-d941-473e-b1f6-99f12d61fcc8');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', 'c543883a-6aab-4ee7-86e4-b11937f30755');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('5fcf9430-8b9f-4503-a9bc-8636c7b19a30', 'c543883a-6aab-4ee7-86e4-b11937f30755');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('5fcf9430-8b9f-4503-a9bc-8636c7b19a30', 'c2e878c1-013d-4d5e-bca9-22e0ea549a8d');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('62d2660c-b2c4-4243-a0ad-2ab2738873cb', 'cd17991a-c48e-43a5-8a89-2f25cb64e719');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '2ac1fdea-30ef-452f-b078-c36309490835');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '873ff2d9-21e0-4775-b4c5-93a94254fc5a');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '29c1b91a-dada-451a-82d5-86a53983400f');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', 'f17bf20d-6c16-4b8a-bb7b-d1ed77d782d8');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '0f1d149e-a236-4fee-a6ab-a3d541e0f1e7');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '93cfc0c0-9d9e-4372-a484-21f97d0f1fff');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '51d59ba2-84a2-41d5-abef-a7b02a59fbd3');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '5cddcadc-fe31-443c-b63e-3ae26c620caa');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '9aa74d25-bf7f-4958-a161-d9c985d199bd');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '99ea1560-da4c-4d3e-b48d-59971b8a1a56');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '78a1ea0c-a7b7-4dbe-85b9-e005e66ff964');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', 'b79d47c3-b157-40ea-ac73-719f928bae99');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '16a0d403-fc89-41bf-8efc-4da94598cc82');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', 'e05e9f2e-30b0-4d84-b228-43a726b81e35');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '404eb7e5-d487-4a74-be99-4ec1a06317b8');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '7f1ea64b-9306-42af-a080-c2790c1e9379');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '6188ff98-1c99-417f-abe4-4088804f75a6');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('29c1b91a-dada-451a-82d5-86a53983400f', 'e05e9f2e-30b0-4d84-b228-43a726b81e35');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('29c1b91a-dada-451a-82d5-86a53983400f', '6188ff98-1c99-417f-abe4-4088804f75a6');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('338183bd-58a8-4e2b-8e16-ea21489bfd17', '17fc7bd9-8034-4711-aa94-d0c16977f8ab');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('f17bf20d-6c16-4b8a-bb7b-d1ed77d782d8', '404eb7e5-d487-4a74-be99-4ec1a06317b8');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('338183bd-58a8-4e2b-8e16-ea21489bfd17', 'd247c72f-013d-4a08-8aac-6b651ce7222c');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('d247c72f-013d-4a08-8aac-6b651ce7222c', 'f5425d29-375a-4715-a568-60d30f97c6b9');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('06ea4ce9-88b7-4443-8b22-d2714c71eee3', 'c08b77b6-a0f4-4812-87b5-647317e410a5');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '5e174b57-1549-4a66-9936-b8463f04ce2f');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '931da399-aeb1-4869-b64d-7950ac6b914a');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('338183bd-58a8-4e2b-8e16-ea21489bfd17', 'b6506186-6087-4ce0-bac7-3acef5af4d25');
INSERT INTO public.composite_role (composite, child_role)
VALUES ('338183bd-58a8-4e2b-8e16-ea21489bfd17', '4ed6df97-4ed3-484a-85d8-734fdcf80917');


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data,
                               priority)
VALUES ('fc0157cb-9cf7-45f4-8518-96b4c407f5ba', NULL, 'password', '58c00464-397d-4555-83fa-7297d73901db', 1746374665230,
        NULL,
        '{"value":"Qgf4QY0owhOejknjerHiCalSIvJsoLVGoG3qiTDh4/c=","salt":"du0+58utWKudC1e0a/wVew==","additionalParameters":{}}',
        '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}',
        10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data,
                               priority)
VALUES ('3dca9101-1978-4890-9414-a880b351eb76', NULL, 'password', '3c6348e8-bbf1-4371-a6f7-fbc7c045ac70', 1746398598970,
        'My password',
        '{"value":"n51YCShPpgHJaQk8aQ1k1sFD7EahajTZaz3xY42vrYY=","salt":"rGMyjnoYrREgndel/7PxgA==","additionalParameters":{}}',
        '{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}',
        10);


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml',
        '2025-05-04 16:04:20.455747', 1, 'EXECUTED', '9:6f1016664e21e16d26517a4418f5e3df',
        'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml',
        '2025-05-04 16:04:20.494705', 2, 'MARK_RAN', '9:828775b1596a07d1200ba1d49e5e3941',
        'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2025-05-04 16:04:20.561596', 3,
        'EXECUTED', '9:5f090e44a7d595883c1fb61f4b41fd38',
        'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2025-05-04 16:04:20.564872', 4,
        'EXECUTED', '9:c07e577387a3d2c04d1adc9aaad8730e',
        'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2025-05-04 16:04:20.717605', 5,
        'EXECUTED', '9:b68ce996c655922dbcd2fe6b6ae72686',
        'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2025-05-04 16:04:20.738609',
        6, 'MARK_RAN', '9:543b5c9989f024fe35c6f6c5a97de88e',
        'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2025-05-04 16:04:20.88118', 7,
        'EXECUTED', '9:765afebbe21cf5bbca048e632df38336',
        'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2025-05-04 16:04:20.895227', 8,
        'MARK_RAN', '9:db4a145ba11a6fdaefb397f6dbf829a1',
        'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2025-05-04 16:04:20.906233', 9,
        'EXECUTED', '9:9d05c7be10cdb873f8bcb41bc3a8ab23',
        'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2025-05-04 16:04:21.031693', 10, 'EXECUTED',
        '9:18593702353128d53111f9b1ff0b82b8',
        'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2025-05-04 16:04:21.082372', 11, 'EXECUTED',
        '9:6122efe5f090e41a85c0f1c9e52cbb62',
        'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2025-05-04 16:04:21.087956', 12,
        'MARK_RAN', '9:e1ff28bf7568451453f844c5d54bb0b5',
        'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2025-05-04 16:04:21.101027', 13, 'EXECUTED',
        '9:7af32cd8957fbc069f796b61217483fd',
        'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-05-04 16:04:21.117966', 14,
        'EXECUTED', '9:6005e15e84714cd83226bf7879f54190',
        'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-05-04 16:04:21.119356', 15,
        'MARK_RAN', '9:bf656f5a2b055d07f314431cae76f06c',
        'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-05-04 16:04:21.123722', 16,
        'MARK_RAN', '9:f8dadc9284440469dcf71e25ca6ab99b',
        'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2025-05-04 16:04:21.14901', 17, 'EXECUTED',
        '9:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2025-05-04 16:04:21.178606', 18, 'EXECUTED',
        '9:3368ff0be4c2855ee2dd9ca813b38d8e',
        'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2025-05-04 16:04:21.218689', 19,
        'EXECUTED', '9:8ac2fb5dd030b24c0570a763ed75ed20',
        'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2025-05-04 16:04:21.222521', 20, 'EXECUTED',
        '9:f91ddca9b19743db60e3057679810e6c',
        'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.25.1',
        NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('24.0.0-9758-2', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-05-04 16:04:22.171472', 119, 'EXECUTED',
        '9:bf0fdee10afdf597a987adbf291db7b2', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-05-04 16:04:21.225836', 21,
        'MARK_RAN', '9:831e82914316dc8a57dc09d755f23c51',
        'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2025-05-04 16:04:21.228359', 22, 'MARK_RAN',
        '9:f91ddca9b19743db60e3057679810e6c',
        'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '4.25.1',
        NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2025-05-04 16:04:21.247573', 23,
        'EXECUTED', '9:bc3d0f9e823a69dc21e23e94c7a94bb1',
        'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2025-05-04 16:04:21.251833', 24, 'EXECUTED',
        '9:c9999da42f543575ab790e76439a2679',
        'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2025-05-04 16:04:21.253345', 25, 'MARK_RAN',
        '9:0d6c65c6f58732d81569e77b10ba301d',
        'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2025-05-04 16:04:21.271896', 26, 'EXECUTED',
        '9:fc576660fc016ae53d2d4778d84d86d0',
        'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2025-05-04 16:04:21.31309', 27,
        'EXECUTED', '9:43ed6b0da89ff77206289e87eaa9c024',
        'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2025-05-04 16:04:21.317809', 28,
        'EXECUTED', '9:44bae577f551b3738740281eceb4ea70', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '4.25.1',
        NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2025-05-04 16:04:21.351675',
        29, 'EXECUTED', '9:bd88e1f833df0420b01e114533aee5e8',
        'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2025-05-04 16:04:21.361863', 30, 'EXECUTED',
        '9:a7022af5267f019d020edfe316ef4371',
        'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2025-05-04 16:04:21.374356', 31, 'EXECUTED',
        '9:fc155c394040654d6a79227e56f5e25a',
        'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2025-05-04 16:04:21.380075', 32, 'EXECUTED',
        '9:eac4ffb2a14795e5dc7b426063e54d88', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-05-04 16:04:21.385089', 33, 'EXECUTED',
        '9:54937c05672568c4c64fc9524c1e9462',
        'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2025-05-04 16:04:21.38736',
        34, 'MARK_RAN', '9:3a32bace77c84d7678d035a7f5a8084e',
        'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml',
        '2025-05-04 16:04:21.408585', 35, 'EXECUTED', '9:33d72168746f81f98ae3a1e8e0ca3554',
        'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml',
        '2025-05-04 16:04:21.414695', 36, 'EXECUTED', '9:61b6d3d7a4c0e0024b0c839da283da0c', 'addColumn tableName=REALM',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml',
        '2025-05-04 16:04:21.419306', 37, 'EXECUTED', '9:8dcac7bdf7378e7d823cdfddebf72fda',
        'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2025-05-04 16:04:21.421584', 38, 'EXECUTED',
        '9:a2b870802540cb3faa72098db5388af3', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2025-05-04 16:04:21.423339', 39, 'EXECUTED',
        '9:132a67499ba24bcc54fb5cbdcfe7e4c0', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-05-04 16:04:21.424396', 40, 'MARK_RAN',
        '9:938f894c032f5430f2b0fafb1a243462',
        'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-05-04 16:04:21.426438',
        41, 'MARK_RAN', '9:845c332ff1874dc5d35974b0babf3006',
        'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2025-05-04 16:04:21.433341', 42,
        'EXECUTED', '9:fc86359c079781adc577c5a217e4d04c', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2025-05-04 16:04:21.492193', 43, 'EXECUTED',
        '9:59a64800e3c0d09b825f8a3b444fa8f4',
        'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2025-05-04 16:04:21.494821', 44, 'EXECUTED',
        '9:d48d6da5c6ccf667807f633fe489ce88', 'addColumn tableName=USER_ENTITY', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com',
        'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-05-04 16:04:21.497028', 45, 'EXECUTED',
        '9:dde36f7973e80d71fceee683bc5d2951',
        'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com',
        'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-05-04 16:04:21.500917', 46, 'EXECUTED',
        '9:b855e9b0a406b34fa323235a0cf4f640', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com',
        'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-05-04 16:04:21.501593', 47, 'MARK_RAN',
        '9:51abbacd7b416c50c4421a8cabf7927e',
        'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com',
        'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2025-05-04 16:04:21.530874', 48, 'EXECUTED',
        '9:bdc99e567b3398bac83263d375aad143',
        'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml',
        '2025-05-04 16:04:21.534339', 49, 'EXECUTED', '9:d198654156881c46bfba39abd7769e69', 'addColumn tableName=REALM',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2025-05-04 16:04:21.555469', 50, 'EXECUTED',
        '9:cfdd8736332ccdd72c5256ccb42335db',
        'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2025-05-04 16:04:21.569177',
        51, 'EXECUTED', '9:7c84de3d9bd84d7f077607c1a4dcb714',
        'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2025-05-04 16:04:21.571599', 52, 'EXECUTED',
        '9:5a6bb36cbefb6a9d6928452c0852af2d', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2025-05-04 16:04:21.573858', 53, 'EXECUTED',
        '9:8f23e334dbc59f82e0a328373ca6ced0', 'update tableName=REALM', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2025-05-04 16:04:21.575436',
        54, 'EXECUTED', '9:9156214268f09d970cdf0e1564d866af', 'update tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-05-04 16:04:21.578882',
        55, 'EXECUTED', '9:db806613b1ed154826c02610b7dbdf74',
        'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml',
        '2025-05-04 16:04:21.581658', 56, 'EXECUTED', '9:229a041fb72d5beac76bb94a5fa709de',
        'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2025-05-04 16:04:21.593131',
        57, 'EXECUTED', '9:079899dade9c1e683f26b2aa9ca6ff04',
        'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml',
        '2025-05-04 16:04:21.674595', 58, 'EXECUTED', '9:139b79bcbbfe903bb1c2d2a4dbf001d9',
        'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml',
        '2025-05-04 16:04:21.692451', 59, 'EXECUTED', '9:b55738ad889860c625ba2bf483495a04',
        'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml',
        '2025-05-04 16:04:21.699365', 60, 'EXECUTED', '9:e0057eac39aa8fc8e09ac6cfa4ae15fe',
        'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml',
        '2025-05-04 16:04:21.708277', 61, 'EXECUTED', '9:42a33806f3a0443fe0e7feeec821326c',
        'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml',
        '2025-05-04 16:04:21.711972', 62, 'EXECUTED', '9:9968206fca46eecc1f51db9c024bfe56',
        'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2025-05-04 16:04:21.715258',
        63, 'EXECUTED', '9:92143a6daea0a3f3b8f598c97ce55c3d', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2025-05-04 16:04:21.717732',
        64, 'EXECUTED', '9:82bab26a27195d889fb0429003b18f40', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-05-04 16:04:21.7203', 65,
        'EXECUTED', '9:e590c88ddc0b38b0ae4249bbfcb5abc3', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2025-05-04 16:04:21.727981', 66,
        'EXECUTED', '9:5c1f475536118dbdc38d5d7977950cc0',
        'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2025-05-04 16:04:21.730947',
        67, 'EXECUTED', '9:e7c9f5f9c4d67ccbbcc215440c718a17',
        'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2025-05-04 16:04:21.733794',
        68, 'EXECUTED', '9:88e0bfdda924690d6f4e430c53447dd5', 'addColumn tableName=REALM', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2025-05-04 16:04:21.75232', 69,
        'EXECUTED', '9:f53177f137e1c46b6a88c59ec1cb5218',
        'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2025-05-04 16:04:21.756387',
        70, 'EXECUTED', '9:a74d33da4dc42a37ec27121580d1459f',
        'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml',
        '2025-05-04 16:04:21.759942', 71, 'EXECUTED', '9:fd4ade7b90c3b67fae0bfcfcb42dfb5f',
        'addColumn tableName=RESOURCE_SERVER', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-05-04 16:04:21.766072',
        72, 'EXECUTED', '9:aa072ad090bbba210d8f18781b8cebf4',
        'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml',
        '2025-05-04 16:04:21.77419', 73, 'EXECUTED', '9:1ae6be29bab7c2aa376f6983b932be37',
        'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml',
        '2025-05-04 16:04:21.776243', 74, 'MARK_RAN', '9:14706f286953fc9a25286dbd8fb30d97',
        'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-05-04 16:04:21.848876',
        75, 'EXECUTED', '9:2b9cc12779be32c5b40e2e67711a218b',
        'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2025-05-04 16:04:21.873856', 76,
        'EXECUTED', '9:91fa186ce7a5af127a2d7a91ee083cc5',
        'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '',
        NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2025-05-04 16:04:21.877617', 77,
        'EXECUTED', '9:6335e5c94e83a2639ccd68dd24e2e5ad', 'addColumn tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml',
        '2025-05-04 16:04:21.879204', 78, 'MARK_RAN', '9:6bdb5658951e028bfe16fa0a8228b530',
        'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml',
        '2025-05-04 16:04:21.909202', 79, 'EXECUTED', '9:d5bc15a64117ccad481ce8792d4c608f',
        'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml',
        '2025-05-04 16:04:21.913436', 80, 'MARK_RAN', '9:077cba51999515f4d3e7ad5619ab592c',
        'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml',
        '2025-05-04 16:04:21.927325', 81, 'EXECUTED', '9:be969f08a163bf47c6b9e9ead8ac2afb',
        'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml',
        '2025-05-04 16:04:21.928527', 82, 'MARK_RAN', '9:6d3bb4408ba5a72f39bd8a0b301ec6e3',
        'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml',
        '2025-05-04 16:04:21.933285', 83, 'EXECUTED', '9:966bda61e46bebf3cc39518fbed52fa7',
        'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml',
        '2025-05-04 16:04:21.934575', 84, 'MARK_RAN', '9:8dcac7bdf7378e7d823cdfddebf72fda',
        'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2025-05-04 16:04:21.940033', 85,
        'EXECUTED', '9:7d93d602352a30c0c317e6a609b56599',
        'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2025-05-04 16:04:21.943536', 86, 'EXECUTED',
        '9:71c5969e6cdd8d7b6f47cebc86d37627',
        'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2025-05-04 16:04:21.946536', 87, 'EXECUTED',
        '9:a9ba7d47f065f041b7da856a81762021',
        'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml',
        '2025-05-04 16:04:21.955569', 88, 'EXECUTED', '9:fffabce2bc01e1a8f5110d5278500065',
        'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '4.25.1',
        NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-05-04 16:04:21.963688', 89, 'EXECUTED',
        '9:fa8a5b5445e3857f4b010bafb5009957', 'addColumn tableName=REALM; customChange', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-05-04 16:04:21.968601', 90,
        'EXECUTED', '9:67ac3241df9a8582d591c5ed87125f39',
        'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-05-04 16:04:21.972641', 91,
        'EXECUTED', '9:ad1194d66c937e3ffc82386c050ba089',
        'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-05-04 16:04:21.975894', 92,
        'EXECUTED', '9:d9be619d94af5a2f5d07b9f003543b91',
        'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml',
        '2025-05-04 16:04:21.976802', 93, 'MARK_RAN', '9:544d201116a0fcc5a5da0925fbbc3bde',
        'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml',
        '2025-05-04 16:04:21.98173', 94, 'EXECUTED', '9:43c0c1055b6761b4b3e89de76d612ccf',
        'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml',
        '2025-05-04 16:04:21.983165', 95, 'MARK_RAN', '9:8bd711fd0330f4fe980494ca43ab1139',
        'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2025-05-04 16:04:21.989847',
        96, 'EXECUTED', '9:e07d2bc0970c348bb06fb63b1f82ddbf',
        'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-05-04 16:04:21.995982', 97,
        'EXECUTED', '9:24fb8611e97f29989bea412aa38d12b7',
        'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-05-04 16:04:21.997225', 98,
        'MARK_RAN', '9:259f89014ce2506ee84740cbf7163aa7',
        'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2025-05-04 16:04:22.018393',
        99, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022',
        'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml',
        '2025-05-04 16:04:22.02845', 100, 'EXECUTED', '9:60ca84a0f8c94ec8c3504a5a3bc88ee8',
        'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml',
        '2025-05-04 16:04:22.03569', 101, 'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9',
        'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml',
        '2025-05-04 16:04:22.050334', 102, 'EXECUTED', '9:0b305d8d1277f3a89a0a53a659ad274c',
        'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml',
        '2025-05-04 16:04:22.061376', 103, 'EXECUTED', '9:2c374ad2cdfe20e2905a84c8fac48460', 'customChange', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2025-05-04 16:04:22.070436', 104,
        'EXECUTED', '9:47a760639ac597360a8219f5b768b4de',
        'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('17.0.0-9562', 'keycloak', 'META-INF/jpa-changelog-17.0.0.xml', '2025-05-04 16:04:22.081158', 105, 'EXECUTED',
        '9:a6272f0576727dd8cad2522335f5d99e', 'createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('18.0.0-10625-IDX_ADMIN_EVENT_TIME', 'keycloak', 'META-INF/jpa-changelog-18.0.0.xml',
        '2025-05-04 16:04:22.08731', 106, 'EXECUTED', '9:015479dbd691d9cc8669282f4828c41d',
        'createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('19.0.0-10135', 'keycloak', 'META-INF/jpa-changelog-19.0.0.xml', '2025-05-04 16:04:22.097568', 107, 'EXECUTED',
        '9:9518e495fdd22f78ad6425cc30630221', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('20.0.0-12964-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-05-04 16:04:22.10701', 108,
        'EXECUTED', '9:e5f243877199fd96bcc842f27a1656ac',
        'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('20.0.0-12964-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml', '2025-05-04 16:04:22.10866',
        109, 'MARK_RAN', '9:1a6fcaa85e20bdeae0a9ce49b41946a5',
        'createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('client-attributes-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-20.0.0.xml',
        '2025-05-04 16:04:22.118172', 110, 'EXECUTED', '9:3f332e13e90739ed0c35b0b25b7822ca',
        'addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('21.0.2-17277', 'keycloak', 'META-INF/jpa-changelog-21.0.2.xml', '2025-05-04 16:04:22.125735', 111, 'EXECUTED',
        '9:7ee1f7a3fb8f5588f171fb9a6ab623c0', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('21.1.0-19404', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-05-04 16:04:22.14281', 112, 'EXECUTED',
        '9:3d7e830b52f33676b9d64f7f2b2ea634',
        'modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('21.1.0-19404-2', 'keycloak', 'META-INF/jpa-changelog-21.1.0.xml', '2025-05-04 16:04:22.145371', 113,
        'MARK_RAN', '9:627d032e3ef2c06c0e1f73d2ae25c26c',
        'addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('22.0.0-17484-updated', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-05-04 16:04:22.150739', 114,
        'EXECUTED', '9:90af0bfd30cafc17b9f4d6eccd92b8b3', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('22.0.5-24031', 'keycloak', 'META-INF/jpa-changelog-22.0.0.xml', '2025-05-04 16:04:22.151877', 115, 'MARK_RAN',
        '9:a60d2d7b315ec2d3eba9e2f145f9df28', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('23.0.0-12062', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-05-04 16:04:22.15658', 116, 'EXECUTED',
        '9:2168fbe728fec46ae9baf15bf80927b8',
        'addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('23.0.0-17258', 'keycloak', 'META-INF/jpa-changelog-23.0.0.xml', '2025-05-04 16:04:22.158107', 117, 'EXECUTED',
        '9:36506d679a83bbfda85a27ea1864dca8', 'addColumn tableName=EVENT_ENTITY', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('24.0.0-9758', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-05-04 16:04:22.166', 118, 'EXECUTED',
        '9:502c557a5189f600f0f445a9b49ebbce',
        'addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('24.0.0-26618-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml',
        '2025-05-04 16:04:22.177189', 120, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022',
        'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('24.0.0-26618-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.0.xml', '2025-05-04 16:04:22.18072', 121,
        'EXECUTED', '9:08707c0f0db1cef6b352db03a60edc7f',
        'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('24.0.2-27228', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-05-04 16:04:22.184772', 122, 'EXECUTED',
        '9:eaee11f6b8aa25d2cc6a84fb86fc6238', 'customChange', '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('24.0.2-27967-drop-index-if-present', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml',
        '2025-05-04 16:04:22.186165', 123, 'MARK_RAN', '9:04baaf56c116ed19951cbc2cca584022',
        'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL, NULL,
        '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('24.0.2-27967-reindex', 'keycloak', 'META-INF/jpa-changelog-24.0.2.xml', '2025-05-04 16:04:22.187248', 124,
        'MARK_RAN', '9:d3d977031d431db16e2c181ce49d73e9',
        'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '4.25.1', NULL,
        NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('25.0.0-28265-tables', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.192922', 125,
        'EXECUTED', '9:deda2df035df23388af95bbd36c17cef',
        'addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION', '', NULL, '4.25.1',
        NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('25.0.0-28265-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.195952',
        126, 'EXECUTED', '9:3e96709818458ae49f3c679ae58d263a',
        'createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('25.0.0-28265-index-cleanup', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.200825',
        127, 'EXECUTED', '9:8c0cfa341a0474385b324f5c4b2dfcc1',
        'dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('25.0.0-28265-index-2-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.202183',
        128, 'MARK_RAN', '9:b7ef76036d3126bb83c2423bf4d449d6',
        'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('25.0.0-28265-index-2-not-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.206403',
        129, 'EXECUTED', '9:23396cf51ab8bc1ae6f0cac7f9f6fcf7',
        'createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION', '', NULL,
        '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('25.0.0-org', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.222209', 130, 'EXECUTED',
        '9:5c859965c2c9b9c72136c360649af157',
        'createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('unique-consentuser', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.229957', 131,
        'EXECUTED', '9:5857626a2ea8767e9a6c66bf3a2cb32f',
        'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('unique-consentuser-mysql', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.232446', 132,
        'MARK_RAN', '9:b79478aad5adaa1bc428e31563f55e8e',
        'customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description,
                                      comments, tag, liquibase, contexts, labels, deployment_id)
VALUES ('25.0.0-28861-index-creation', 'keycloak', 'META-INF/jpa-changelog-25.0.0.xml', '2025-05-04 16:04:22.236092',
        133, 'EXECUTED', '9:b9acb58ac958d9ada0fe12a5d4794ab1',
        'createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET',
        '', NULL, '4.25.1', NULL, NULL, '6374659897');


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby)
VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby)
VALUES (1000, false, NULL, NULL);


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'c6f91adf-e0b3-466b-bea2-1e8e55f5b5af', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '7c162f5f-3729-4cfb-9cc4-77e6ec9dbb01', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'cc457349-d42c-4c3b-96f1-a672dee20fb0', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '7cdc7a4e-1694-4859-b8f2-0025e6e8a088', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'a0d9a989-aeae-459d-b12f-86258f0e7513', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '3912870a-6454-4381-875c-280f06306038', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '2241a6ab-6941-4593-ab15-c3466042e3ff', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '311098a8-67f5-4814-86a5-9364da34bf85', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f3735d70-e972-4254-af4f-cbf7c57556aa', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '820650ee-3e6a-4412-b376-3f2ca1267cfd', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', '908c630f-01fe-4258-87f4-1036ae43b8de', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', 'd6f685bb-53c8-4497-a67c-4b52e121ef73', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', '6a315622-937a-4e9c-b2a8-d20fb74a7722', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', 'dcba5777-e488-4320-9f37-fc2aad5e8e77', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', 'f16cde5d-f859-47ab-abc3-b54049f001f0', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', 'f9c67dc0-6a3d-426e-8086-b7c2181c1187', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', '84286307-9f7d-434b-9d61-0bcdccb02446', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', '7e4b35e7-a2c6-4937-af85-a16191edc053', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', 'c18c446e-df26-4c0c-927b-ad3984b4f37e', true);


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('3755f040-41d7-49e4-847b-ac896c124262', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', false, '${role_default-roles}',
        'default-roles-master', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', false, '${role_admin}', 'admin',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('af87e5e3-16ec-4436-b17d-25d2780f229c', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', false, '${role_create-realm}',
        'create-realm', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f3b12638-a018-4eda-af5f-0e677e1f2fa3', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_create-client}',
        'create-client', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('df7f8af1-30f4-4cce-905a-bb8b97aa73bb', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_view-realm}',
        'view-realm', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('9afff77f-b753-4f99-bca0-d59391672fdf', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_view-users}',
        'view-users', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('8e852909-d143-4475-874b-9f27f5d7f885', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_view-clients}',
        'view-clients', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('a258c392-d537-4eca-8f4e-99c9d7849061', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_view-events}',
        'view-events', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('bed3c950-872b-4f62-a651-abd6ef85909d', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true,
        '${role_view-identity-providers}', 'view-identity-providers', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('30a35e8e-45e1-42f5-b956-667fff9c8267', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true,
        '${role_view-authorization}', 'view-authorization', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('cb948413-64fc-4121-b171-d22957eea549', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_manage-realm}',
        'manage-realm', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f0799c04-f07b-4678-93e7-7992e3b312a1', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_manage-users}',
        'manage-users', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('d50a09ca-5072-4350-81f6-abd218aeb951', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_manage-clients}',
        'manage-clients', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('921c38fe-56cb-4208-a846-a0e64d23eaf9', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_manage-events}',
        'manage-events', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('65d0342f-f094-4a05-bb9c-b120b60b5ed2', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true,
        '${role_manage-identity-providers}', 'manage-identity-providers', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('8090370d-dce8-413a-99d3-f7836451cddb', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true,
        '${role_manage-authorization}', 'manage-authorization', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('58b60710-606f-40a6-ac4f-f34397babf19', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_query-users}',
        'query-users', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('ebcbe6e7-a7c0-43c9-b3d0-9ff29433d286', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_query-clients}',
        'query-clients', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('c6a303de-90b7-4a42-9ea2-5aa65b30b72b', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_query-realms}',
        'query-realms', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('90b64bc6-a509-42b1-a534-c9ea6a7a3395', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_query-groups}',
        'query-groups', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('5c0fd52f-aea2-464f-9b8d-c82b5ba5d362', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true, '${role_view-profile}',
        'view-profile', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('cd410a61-b616-4d96-8c38-08776a5c0e4c', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true, '${role_manage-account}',
        'manage-account', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f0eb8bf5-c9cc-442d-96f7-fcdda071e8c4', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true,
        '${role_manage-account-links}', 'manage-account-links', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('e95b0d4e-aa5f-4a37-8b28-907ebdd81938', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true,
        '${role_view-applications}', 'view-applications', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('5f7cd433-0444-4a35-8e30-c3d17ff630c7', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true, '${role_view-consent}',
        'view-consent', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('c4d6d3ef-5387-4cd0-a461-6794543c2d99', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true, '${role_manage-consent}',
        'manage-consent', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('10bb1a01-7e56-4e59-8c88-df3b6d140794', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true, '${role_view-groups}',
        'view-groups', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('3c08649a-89f9-4223-9869-ee2ca177f6be', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', true, '${role_delete-account}',
        'delete-account', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'e8ee0991-303f-4ff1-a549-b70cdef4c8c1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('7f4cce3e-a28e-4838-a6b5-fadfcd3f3183', '874da0a8-b38c-4fe6-854b-d2560708ab0e', true, '${role_read-token}',
        'read-token', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '874da0a8-b38c-4fe6-854b-d2560708ab0e', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('492c7bb1-a0d2-46d9-8b7b-27d587c7f078', 'f11d5027-2c04-4289-821a-5cd30dca6e66', true, '${role_impersonation}',
        'impersonation', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'f11d5027-2c04-4289-821a-5cd30dca6e66', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('805b73e9-feca-43ea-bcbc-caf8944aab18', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', false, '${role_offline-access}',
        'offline_access', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('95694cee-44fc-40e4-8951-517ce5dabce9', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', false,
        '${role_uma_authorization}', 'uma_authorization', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('338183bd-58a8-4e2b-8e16-ea21489bfd17', '620962b5-3bd3-421b-a251-19eb7e5a870e', false, '${role_default-roles}',
        'default-roles-dms', '620962b5-3bd3-421b-a251-19eb7e5a870e', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('79d0b27e-b04e-4f8f-abbc-58c730a7ac18', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_create-client}',
        'create-client', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f674c01d-4b2e-4446-8cc8-2503d615fddc', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_view-realm}',
        'view-realm', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('5fcf9430-8b9f-4503-a9bc-8636c7b19a30', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_view-users}',
        'view-users', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('62d2660c-b2c4-4243-a0ad-2ab2738873cb', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_view-clients}',
        'view-clients', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f8b0b5d9-6a13-4959-9363-158db1816628', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_view-events}',
        'view-events', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('3f1ae63d-bdc9-4c76-a88d-09efb017c5c3', '63c5d382-f272-40df-8399-a911e949c9aa', true,
        '${role_view-identity-providers}', 'view-identity-providers', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('d3fee103-70ea-4f1b-a302-7e6c60d90be1', '63c5d382-f272-40df-8399-a911e949c9aa', true,
        '${role_view-authorization}', 'view-authorization', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('c4edd002-0e6d-450b-806c-6784a0022bed', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_manage-realm}',
        'manage-realm', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('4bdc51ef-eff6-4b7c-855b-c741f042b969', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_manage-users}',
        'manage-users', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f306c0dc-4998-48c8-baef-ef9d51d4fa03', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_manage-clients}',
        'manage-clients', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('e1533655-40da-4f9b-961c-c337c9c4bd33', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_manage-events}',
        'manage-events', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('65cfa32e-f103-43ab-a0ac-db6e91c79091', '63c5d382-f272-40df-8399-a911e949c9aa', true,
        '${role_manage-identity-providers}', 'manage-identity-providers', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('e38ed989-0619-47a8-afaa-416920e40861', '63c5d382-f272-40df-8399-a911e949c9aa', true,
        '${role_manage-authorization}', 'manage-authorization', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('c2e878c1-013d-4d5e-bca9-22e0ea549a8d', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_query-users}',
        'query-users', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('cd17991a-c48e-43a5-8a89-2f25cb64e719', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_query-clients}',
        'query-clients', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('4fb31236-d941-473e-b1f6-99f12d61fcc8', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_query-realms}',
        'query-realms', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('c543883a-6aab-4ee7-86e4-b11937f30755', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_query-groups}',
        'query-groups', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('7f830086-33c9-411f-89a4-3fcd4a442861', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_realm-admin}',
        'realm-admin', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('2ac1fdea-30ef-452f-b078-c36309490835', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_create-client}',
        'create-client', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('873ff2d9-21e0-4775-b4c5-93a94254fc5a', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_view-realm}',
        'view-realm', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('29c1b91a-dada-451a-82d5-86a53983400f', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_view-users}',
        'view-users', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f17bf20d-6c16-4b8a-bb7b-d1ed77d782d8', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_view-clients}',
        'view-clients', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('0f1d149e-a236-4fee-a6ab-a3d541e0f1e7', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_view-events}',
        'view-events', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('93cfc0c0-9d9e-4372-a484-21f97d0f1fff', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true,
        '${role_view-identity-providers}', 'view-identity-providers', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('51d59ba2-84a2-41d5-abef-a7b02a59fbd3', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true,
        '${role_view-authorization}', 'view-authorization', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('5cddcadc-fe31-443c-b63e-3ae26c620caa', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_manage-realm}',
        'manage-realm', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('9aa74d25-bf7f-4958-a161-d9c985d199bd', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_manage-users}',
        'manage-users', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('99ea1560-da4c-4d3e-b48d-59971b8a1a56', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_manage-clients}',
        'manage-clients', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('78a1ea0c-a7b7-4dbe-85b9-e005e66ff964', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_manage-events}',
        'manage-events', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('b79d47c3-b157-40ea-ac73-719f928bae99', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true,
        '${role_manage-identity-providers}', 'manage-identity-providers', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('16a0d403-fc89-41bf-8efc-4da94598cc82', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true,
        '${role_manage-authorization}', 'manage-authorization', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('e05e9f2e-30b0-4d84-b228-43a726b81e35', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_query-users}',
        'query-users', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('404eb7e5-d487-4a74-be99-4ec1a06317b8', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_query-clients}',
        'query-clients', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('7f1ea64b-9306-42af-a080-c2790c1e9379', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_query-realms}',
        'query-realms', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('6188ff98-1c99-417f-abe4-4088804f75a6', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_query-groups}',
        'query-groups', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('17fc7bd9-8034-4711-aa94-d0c16977f8ab', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true, '${role_view-profile}',
        'view-profile', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('d247c72f-013d-4a08-8aac-6b651ce7222c', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true, '${role_manage-account}',
        'manage-account', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('f5425d29-375a-4715-a568-60d30f97c6b9', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true,
        '${role_manage-account-links}', 'manage-account-links', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('d595f98d-2cb0-414b-912a-2de00dbf1f8f', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true,
        '${role_view-applications}', 'view-applications', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('c08b77b6-a0f4-4812-87b5-647317e410a5', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true, '${role_view-consent}',
        'view-consent', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('06ea4ce9-88b7-4443-8b22-d2714c71eee3', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true, '${role_manage-consent}',
        'manage-consent', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('dd6fd303-884c-4afd-a0cf-c9b462951d97', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true, '${role_view-groups}',
        'view-groups', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('ce064786-de99-4c28-a4ac-5f4e2b396a2d', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', true, '${role_delete-account}',
        'delete-account', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('5e174b57-1549-4a66-9936-b8463f04ce2f', '63c5d382-f272-40df-8399-a911e949c9aa', true, '${role_impersonation}',
        'impersonation', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '63c5d382-f272-40df-8399-a911e949c9aa', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('931da399-aeb1-4869-b64d-7950ac6b914a', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', true, '${role_impersonation}',
        'impersonation', '620962b5-3bd3-421b-a251-19eb7e5a870e', '671bdfdb-f7f2-466f-91fe-1f0c4b1abfc7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('97317a10-f2b7-427b-a796-4c021bafc0fa', '33327f2b-7d91-4592-ac41-9575a07e0eb1', true, '${role_read-token}',
        'read-token', '620962b5-3bd3-421b-a251-19eb7e5a870e', '33327f2b-7d91-4592-ac41-9575a07e0eb1', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('b6506186-6087-4ce0-bac7-3acef5af4d25', '620962b5-3bd3-421b-a251-19eb7e5a870e', false, '${role_offline-access}',
        'offline_access', '620962b5-3bd3-421b-a251-19eb7e5a870e', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm)
VALUES ('4ed6df97-4ed3-484a-85d8-734fdcf80917', '620962b5-3bd3-421b-a251-19eb7e5a870e', false,
        '${role_uma_authorization}', 'uma_authorization', '620962b5-3bd3-421b-a251-19eb7e5a870e', NULL, NULL);


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migration_model (id, version, update_time)
VALUES ('faj0w', '25.0.0', 1746374662);


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('0b9205ee-b407-4299-b2df-9f007656dab8', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper',
        '09cb8fab-662c-42c1-b879-1c81cb5a239b', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        '0263cdd2-cf8a-41dc-940f-67b4665fefc8', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('09aabc87-2ff3-495c-9e37-bf63ddf381a6', 'role list', 'saml', 'saml-role-list-mapper', NULL,
        '7c162f5f-3729-4cfb-9cc4-77e6ec9dbb01');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('8630fd59-1478-42c5-8cdf-06ebb86173a2', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        NULL, 'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        NULL, 'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'cc457349-d42c-4c3b-96f1-a672dee20fb0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '7cdc7a4e-1694-4859-b8f2-0025e6e8a088');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper',
        NULL, '7cdc7a4e-1694-4859-b8f2-0025e6e8a088');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'address', 'openid-connect', 'oidc-address-mapper', NULL,
        'a0d9a989-aeae-459d-b12f-86258f0e7513');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        NULL, 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'phone number verified', 'openid-connect',
        'oidc-usermodel-attribute-mapper', NULL, 'ce929fa8-923c-4c11-94c2-7a0c6d34e17b');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('a598d5b8-4a0c-47e1-9902-b3401da1a1d3', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper',
        NULL, '3912870a-6454-4381-875c-280f06306038');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('00120ee6-3625-43d3-9d7a-f29dfe3afb38', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper',
        NULL, '3912870a-6454-4381-875c-280f06306038');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('63cc6710-5c51-4f04-8c46-0597947e03c4', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper',
        NULL, '3912870a-6454-4381-875c-280f06306038');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('9511ddf5-c0ed-4e3f-bb0a-10ee6416fdd4', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper',
        NULL, '2241a6ab-6941-4593-ab15-c3466042e3ff');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '311098a8-67f5-4814-86a5-9364da34bf85');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL,
        '311098a8-67f5-4814-86a5-9364da34bf85');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('b3efe495-076b-4149-b5ba-8251e581f509', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL,
        'f3735d70-e972-4254-af4f-cbf7c57556aa');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('9164140d-c7bb-47e8-a733-dca636d14b1d', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper',
        NULL, '820650ee-3e6a-4412-b376-3f2ca1267cfd');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('121d1c42-8afe-47b2-be90-3adf90963103', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL,
        '820650ee-3e6a-4412-b376-3f2ca1267cfd');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('56308a6a-b05b-4944-90fe-3133e9718ed4', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper',
        '31457512-e505-416e-8197-23868d87e0ae', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('d63dd4e1-381d-44b0-a064-394815f3ca81', 'role list', 'saml', 'saml-role-list-mapper', NULL,
        'd6f685bb-53c8-4497-a67c-4b52e121ef73');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('56f58055-c5d7-464b-b095-6a95720de310', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'family name', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        NULL, '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'given name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        NULL, '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'username', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '6a315622-937a-4e9c-b2a8-d20fb74a7722');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'email', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        'dcba5777-e488-4320-9f37-fc2aad5e8e77');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper',
        NULL, 'dcba5777-e488-4320-9f37-fc2aad5e8e77');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'address', 'openid-connect', 'oidc-address-mapper', NULL,
        'f16cde5d-f859-47ab-abc3-b54049f001f0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        NULL, '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'phone number verified', 'openid-connect',
        'oidc-usermodel-attribute-mapper', NULL, '9d1b298b-7315-4d16-b6c1-4f1d2cc8ec80');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('905ca3e2-5c12-4a78-a169-5a56ea989baf', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper',
        NULL, 'f9c67dc0-6a3d-426e-8086-b7c2181c1187');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('f9309945-eaca-476b-9031-592465ebd29c', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper',
        NULL, 'f9c67dc0-6a3d-426e-8086-b7c2181c1187');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('5d841cbf-9f30-45b2-81f6-5b6bcfd666e4', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper',
        NULL, 'f9c67dc0-6a3d-426e-8086-b7c2181c1187');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('f25e3982-3b56-4226-8976-7939a2b4c4ff', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper',
        NULL, '25a5b8b1-cc99-4e92-b6b8-229ac1d03c01');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'upn', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL,
        '84286307-9f7d-434b-9d61-0bcdccb02446');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL,
        '84286307-9f7d-434b-9d61-0bcdccb02446');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('d99e395d-3239-4ea6-a857-5aa448465205', 'acr loa level', 'openid-connect', 'oidc-acr-mapper', NULL,
        '7e4b35e7-a2c6-4937-af85-a16191edc053');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('d6141746-b0c7-4325-b24d-f2e4c3c24065', 'auth_time', 'openid-connect', 'oidc-usersessionmodel-note-mapper',
        NULL, 'c18c446e-df26-4c0c-927b-ad3984b4f37e');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('eaccc1c0-3ccd-472b-8549-2c06f31a7b82', 'sub', 'openid-connect', 'oidc-sub-mapper', NULL,
        'c18c446e-df26-4c0c-927b-ad3984b4f37e');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper',
        '483f0d5a-9f54-42d5-933d-a3700a7c898f', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('d900c41f-a517-4cad-b78b-69a043e84903', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper',
        'bcca3556-19ad-42e8-a0ca-48206ba498e8', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('9c8a4d81-20a6-426a-87bd-168be46c0fd1', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper',
        'bcca3556-19ad-42e8-a0ca-48206ba498e8', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id)
VALUES ('7ba8abd0-3a8c-4761-8212-e75810efa0f1', 'Client IP Address', 'openid-connect',
        'oidc-usersessionmodel-note-mapper', 'bcca3556-19ad-42e8-a0ca-48206ba498e8', NULL);


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d60c9839-8b06-47d2-9484-ffbe6290658b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09aabc87-2ff3-495c-9e37-bf63ddf381a6', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09aabc87-2ff3-495c-9e37-bf63ddf381a6', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09aabc87-2ff3-495c-9e37-bf63ddf381a6', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1bbdf681-4719-4958-bf58-588c6078fb5a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1f064cea-d86d-439a-9588-2a9d2260546b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5b04c102-3d0a-4f69-be3c-e6aaef27dae8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63ef9240-047e-4a08-bde6-efe890ebd903', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6d29ca7f-25e7-4e52-9a2e-49ab4b84a509', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('840d7982-87e9-4c34-8aa0-5aaa89cbb1cf', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8630fd59-1478-42c5-8cdf-06ebb86173a2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8630fd59-1478-42c5-8cdf-06ebb86173a2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8630fd59-1478-42c5-8cdf-06ebb86173a2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8630fd59-1478-42c5-8cdf-06ebb86173a2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('91a6c625-3f66-43e1-9a1a-ae6b86634d59', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('96ee38ca-fe7d-4876-81c6-5112735e8f8b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a1a2ab90-b009-4c80-b423-1522545a6a8e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a47d7dde-63ca-41bf-a171-828e9c8b4e7e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b5097c2e-3335-4269-9f76-fa6d1f8c22e0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c7a36598-b7b9-413d-bfd3-487b58ec0106', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6be0d3e-0bf0-43ad-8a57-22be7172b6b7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5ddff0b0-3ac3-48ed-bc3b-f372f7d8bea2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a719be8d-3efd-493b-9e91-fa20f389bbf5', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('6dd8396a-e243-4bfd-bc11-10fca17ce93d', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fa62b73-b3a8-4111-b2c3-7673d3df7a29', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9e7f09ed-c43e-4650-8b3a-d782bdd39231', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('00120ee6-3625-43d3-9d7a-f29dfe3afb38', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('00120ee6-3625-43d3-9d7a-f29dfe3afb38', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('00120ee6-3625-43d3-9d7a-f29dfe3afb38', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('00120ee6-3625-43d3-9d7a-f29dfe3afb38', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('00120ee6-3625-43d3-9d7a-f29dfe3afb38', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('00120ee6-3625-43d3-9d7a-f29dfe3afb38', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63cc6710-5c51-4f04-8c46-0597947e03c4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('63cc6710-5c51-4f04-8c46-0597947e03c4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a598d5b8-4a0c-47e1-9902-b3401da1a1d3', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a598d5b8-4a0c-47e1-9902-b3401da1a1d3', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a598d5b8-4a0c-47e1-9902-b3401da1a1d3', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a598d5b8-4a0c-47e1-9902-b3401da1a1d3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a598d5b8-4a0c-47e1-9902-b3401da1a1d3', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a598d5b8-4a0c-47e1-9902-b3401da1a1d3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9511ddf5-c0ed-4e3f-bb0a-10ee6416fdd4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9511ddf5-c0ed-4e3f-bb0a-10ee6416fdd4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('1404817e-d2d4-42b9-bf52-5b0f8755b563', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a57f3472-9ba4-4ab5-9f55-6a835e0ffb87', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b3efe495-076b-4149-b5ba-8251e581f509', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b3efe495-076b-4149-b5ba-8251e581f509', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('b3efe495-076b-4149-b5ba-8251e581f509', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('121d1c42-8afe-47b2-be90-3adf90963103', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('121d1c42-8afe-47b2-be90-3adf90963103', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9164140d-c7bb-47e8-a733-dca636d14b1d', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9164140d-c7bb-47e8-a733-dca636d14b1d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9164140d-c7bb-47e8-a733-dca636d14b1d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9164140d-c7bb-47e8-a733-dca636d14b1d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9164140d-c7bb-47e8-a733-dca636d14b1d', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9164140d-c7bb-47e8-a733-dca636d14b1d', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d63dd4e1-381d-44b0-a064-394815f3ca81', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d63dd4e1-381d-44b0-a064-394815f3ca81', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d63dd4e1-381d-44b0-a064-394815f3ca81', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('309de65b-cd09-4f40-93da-eb355725853e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('39b1bd3b-67ab-499b-ba0e-ebd2cf952291', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4cb9f6a7-43c5-4f10-bc4b-6e271579df22', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('4ebe68bb-c66f-46e7-8606-f4c1fed8dd10', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('56f58055-c5d7-464b-b095-6a95720de310', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('56f58055-c5d7-464b-b095-6a95720de310', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('56f58055-c5d7-464b-b095-6a95720de310', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('56f58055-c5d7-464b-b095-6a95720de310', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5fe3cf44-492e-4c95-b74d-67d112f648c4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('638b3e6c-eff8-4c44-a448-8666a914c6dc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('699334f4-451d-4de0-882c-764ed20b91b2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('79deef33-f83e-4ef7-b147-d3024b90987d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('867ef108-f55e-4b56-8ee3-3543acdcf6c2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('8754ec57-e84d-4bb7-b358-723ff2f21439', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('93da5c28-bcb5-427c-a699-9f762af6335e', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('c34a3920-7f8f-43e6-bb65-552d28eeb386', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('cf86f73e-8250-408e-aabe-d041d5a77ef0', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('811021e2-fd76-4214-9a13-b52829f9db81', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('a74307bd-efc8-453f-ac19-82b55b56778c', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ca0af7f7-8431-4b59-bd61-d7936616d076', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('09d72c35-f8b2-4015-987c-fcd87a3c266c', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ac1bc42d-beb6-402e-ac98-50df2a36947f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5d841cbf-9f30-45b2-81f6-5b6bcfd666e4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('5d841cbf-9f30-45b2-81f6-5b6bcfd666e4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('905ca3e2-5c12-4a78-a169-5a56ea989baf', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('905ca3e2-5c12-4a78-a169-5a56ea989baf', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('905ca3e2-5c12-4a78-a169-5a56ea989baf', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('905ca3e2-5c12-4a78-a169-5a56ea989baf', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('905ca3e2-5c12-4a78-a169-5a56ea989baf', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('905ca3e2-5c12-4a78-a169-5a56ea989baf', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f9309945-eaca-476b-9031-592465ebd29c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f9309945-eaca-476b-9031-592465ebd29c', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f9309945-eaca-476b-9031-592465ebd29c', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f9309945-eaca-476b-9031-592465ebd29c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f9309945-eaca-476b-9031-592465ebd29c', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f9309945-eaca-476b-9031-592465ebd29c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f25e3982-3b56-4226-8976-7939a2b4c4ff', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('f25e3982-3b56-4226-8976-7939a2b4c4ff', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('0a4b2caf-88e6-4935-8c25-9235a329fe8f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('ea178ccb-abe0-448b-85fd-0b7bd117f24c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d99e395d-3239-4ea6-a857-5aa448465205', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d99e395d-3239-4ea6-a857-5aa448465205', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d99e395d-3239-4ea6-a857-5aa448465205', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6141746-b0c7-4325-b24d-f2e4c3c24065', 'AUTH_TIME', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6141746-b0c7-4325-b24d-f2e4c3c24065', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6141746-b0c7-4325-b24d-f2e4c3c24065', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6141746-b0c7-4325-b24d-f2e4c3c24065', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6141746-b0c7-4325-b24d-f2e4c3c24065', 'auth_time', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d6141746-b0c7-4325-b24d-f2e4c3c24065', 'long', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('eaccc1c0-3ccd-472b-8549-2c06f31a7b82', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('eaccc1c0-3ccd-472b-8549-2c06f31a7b82', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7a43af49-cade-488a-bfcf-865ee06d10e4', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7ba8abd0-3a8c-4761-8212-e75810efa0f1', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7ba8abd0-3a8c-4761-8212-e75810efa0f1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7ba8abd0-3a8c-4761-8212-e75810efa0f1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7ba8abd0-3a8c-4761-8212-e75810efa0f1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7ba8abd0-3a8c-4761-8212-e75810efa0f1', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('7ba8abd0-3a8c-4761-8212-e75810efa0f1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9c8a4d81-20a6-426a-87bd-168be46c0fd1', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9c8a4d81-20a6-426a-87bd-168be46c0fd1', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9c8a4d81-20a6-426a-87bd-168be46c0fd1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9c8a4d81-20a6-426a-87bd-168be46c0fd1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9c8a4d81-20a6-426a-87bd-168be46c0fd1', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('9c8a4d81-20a6-426a-87bd-168be46c0fd1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d900c41f-a517-4cad-b78b-69a043e84903', 'client_id', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d900c41f-a517-4cad-b78b-69a043e84903', 'true', 'introspection.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d900c41f-a517-4cad-b78b-69a043e84903', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d900c41f-a517-4cad-b78b-69a043e84903', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d900c41f-a517-4cad-b78b-69a043e84903', 'client_id', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name)
VALUES ('d900c41f-a517-4cad-b78b-69a043e84903', 'String', 'jsonType.label');


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme,
                          admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name,
                          not_before, password_policy, registration_allowed, remember_me, reset_password_allowed,
                          social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login,
                          verify_email, master_admin_client, login_lifespan, internationalization_enabled,
                          default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled,
                          edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period,
                          otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow,
                          direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout,
                          revoke_refresh_token, access_token_life_implicit, login_with_email_allowed,
                          duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse,
                          allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me,
                          default_role)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'dms', 0, NULL,
        false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '63c5d382-f272-40df-8399-a911e949c9aa', 1800,
        false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp',
        '02219ebf-1959-432a-92ab-fc397f15ba93', '7c0fd75f-79ba-4a87-9fcf-0c3bf8558d5b',
        'c00ed738-1c0f-4a3c-b9b5-165595a7acb8', '2061ffd4-8c0b-4d1d-9bf1-30c43fd8e4b4',
        'a24b1aed-e154-4ed1-9c5f-cdfa3bdd5be6', 2592000, false, 900, false, false,
        '5de9d4b1-d165-45ce-914d-310058cf97d3', 0, false, 0, 0, '338183bd-58a8-4e2b-8e16-ea21489bfd17');
INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme,
                          admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name,
                          not_before, password_policy, registration_allowed, remember_me, reset_password_allowed,
                          social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login,
                          verify_email, master_admin_client, login_lifespan, internationalization_enabled,
                          default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled,
                          edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period,
                          otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow,
                          direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout,
                          revoke_refresh_token, access_token_life_implicit, login_with_email_allowed,
                          duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse,
                          allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me,
                          default_role)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL,
        false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'f11d5027-2c04-4289-821a-5cd30dca6e66', 1800,
        false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp',
        '7e6c375e-f21b-454b-a278-677c87d98a41', 'ae495559-9b15-4b9b-bacc-0b7e09940df7',
        '3b1ce050-d5b3-4af1-967c-3ddc064c12d5', '054ee24d-9b9a-4e79-9044-a51d8fb4dfa1',
        '54b6df09-cacb-4d5c-964f-13abcfe34996', 2592000, false, 900, true, false,
        '580baf1f-ad44-46c6-ba90-533bcfdcae61', 0, false, 0, 0, '3755f040-41d7-49e4-847b-ac896c124262');


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.contentSecurityPolicyReportOnly', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xContentTypeOptions', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.referrerPolicy', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'no-referrer');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xRobotsTag', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xFrameOptions', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.contentSecurityPolicy', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xXSSProtection', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.strictTransportSecurity', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('bruteForceProtected', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('permanentLockout', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('maxTemporaryLockouts', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('maxFailureWaitSeconds', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '900');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('minimumQuickLoginWaitSeconds', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '60');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('waitIncrementSeconds', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '60');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('quickLoginCheckMilliSeconds', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('maxDeltaTimeSeconds', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('failureFactor', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '30');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('realmReusableOtpCode', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('firstBrokerLoginFlowId', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'faa8df37-6190-46a8-80f4-5632bc694ffe');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('displayName', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'Keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('displayNameHtml', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('defaultSignatureAlgorithm', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('offlineSessionMaxLifespanEnabled', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('offlineSessionMaxLifespan', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('bruteForceProtected', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('permanentLockout', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('maxTemporaryLockouts', '620962b5-3bd3-421b-a251-19eb7e5a870e', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('maxFailureWaitSeconds', '620962b5-3bd3-421b-a251-19eb7e5a870e', '900');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('minimumQuickLoginWaitSeconds', '620962b5-3bd3-421b-a251-19eb7e5a870e', '60');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('waitIncrementSeconds', '620962b5-3bd3-421b-a251-19eb7e5a870e', '60');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('quickLoginCheckMilliSeconds', '620962b5-3bd3-421b-a251-19eb7e5a870e', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('maxDeltaTimeSeconds', '620962b5-3bd3-421b-a251-19eb7e5a870e', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('failureFactor', '620962b5-3bd3-421b-a251-19eb7e5a870e', '30');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('realmReusableOtpCode', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('defaultSignatureAlgorithm', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('offlineSessionMaxLifespanEnabled', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('offlineSessionMaxLifespan', '620962b5-3bd3-421b-a251-19eb7e5a870e', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('actionTokenGeneratedByAdminLifespan', '620962b5-3bd3-421b-a251-19eb7e5a870e', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('actionTokenGeneratedByUserLifespan', '620962b5-3bd3-421b-a251-19eb7e5a870e', '300');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('oauth2DeviceCodeLifespan', '620962b5-3bd3-421b-a251-19eb7e5a870e', '600');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('oauth2DevicePollingInterval', '620962b5-3bd3-421b-a251-19eb7e5a870e', '5');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyRpEntityName', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicySignatureAlgorithms', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyRpId', '620962b5-3bd3-421b-a251-19eb7e5a870e', '');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyAttestationConveyancePreference', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyAuthenticatorAttachment', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyRequireResidentKey', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyUserVerificationRequirement', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyCreateTimeout', '620962b5-3bd3-421b-a251-19eb7e5a870e', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyRpEntityNamePasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyRpIdPasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e', '');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyCreateTimeoutPasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('cibaBackchannelTokenDeliveryMode', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'poll');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('cibaExpiresIn', '620962b5-3bd3-421b-a251-19eb7e5a870e', '120');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('cibaInterval', '620962b5-3bd3-421b-a251-19eb7e5a870e', '5');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('cibaAuthRequestedUserHint', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'login_hint');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('parRequestUriLifespan', '620962b5-3bd3-421b-a251-19eb7e5a870e', '60');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('firstBrokerLoginFlowId', '620962b5-3bd3-421b-a251-19eb7e5a870e', '53d3eaae-ccdf-4547-a79a-dddcb28def52');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('organizationsEnabled', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('clientSessionIdleTimeout', '620962b5-3bd3-421b-a251-19eb7e5a870e', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('clientSessionMaxLifespan', '620962b5-3bd3-421b-a251-19eb7e5a870e', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('clientOfflineSessionIdleTimeout', '620962b5-3bd3-421b-a251-19eb7e5a870e', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('clientOfflineSessionMaxLifespan', '620962b5-3bd3-421b-a251-19eb7e5a870e', '0');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('client-policies.profiles', '620962b5-3bd3-421b-a251-19eb7e5a870e', '{"profiles":[]}');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('client-policies.policies', '620962b5-3bd3-421b-a251-19eb7e5a870e', '{"policies":[]}');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.contentSecurityPolicyReportOnly', '620962b5-3bd3-421b-a251-19eb7e5a870e', '');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xContentTypeOptions', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.referrerPolicy', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'no-referrer');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xRobotsTag', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xFrameOptions', '620962b5-3bd3-421b-a251-19eb7e5a870e', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.contentSecurityPolicy', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.xXSSProtection', '620962b5-3bd3-421b-a251-19eb7e5a870e', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value)
VALUES ('_browser_header.strictTransportSecurity', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        'max-age=31536000; includeSubDomains');


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_events_listeners (realm_id, value)
VALUES ('9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'jboss-logging');
INSERT INTO public.realm_events_listeners (realm_id, value)
VALUES ('620962b5-3bd3-421b-a251-19eb7e5a870e', 'jboss-logging');


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id)
VALUES ('password', 'password', true, true, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4');
INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id)
VALUES ('password', 'password', true, true, '620962b5-3bd3-421b-a251-19eb7e5a870e');


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.redirect_uris (client_id, value)
VALUES ('e8ee0991-303f-4ff1-a549-b70cdef4c8c1', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', '/admin/master/console/*');
INSERT INTO public.redirect_uris (client_id, value)
VALUES ('ee79cadb-800b-4c1e-8b1c-4ddde4b360f1', '/realms/dms/account/*');
INSERT INTO public.redirect_uris (client_id, value)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', '/realms/dms/account/*');
INSERT INTO public.redirect_uris (client_id, value)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '/admin/dms/console/*');
INSERT INTO public.redirect_uris (client_id, value)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '/*');


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('5e5a91ad-7b3f-41c0-826c-5a296dec3ac8', 'VERIFY_EMAIL', 'Verify Email', '9439a8bc-d375-400d-8eb4-b43a1d70f0a4',
        true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('606411ad-531c-48b7-bc30-5e73af799d44', 'UPDATE_PROFILE', 'Update Profile',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('461334cc-60c7-4d9b-b909-d8513468097e', 'CONFIGURE_TOTP', 'Configure OTP',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('3d1e5a74-544f-4808-bcbd-ed81e97cc3a6', 'UPDATE_PASSWORD', 'Update Password',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('b48e8da9-64ab-40e7-87fe-4c8f0d404240', 'TERMS_AND_CONDITIONS', 'Terms and Conditions',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('c7a84730-fa34-4a32-9b4c-ffcb42186e93', 'delete_account', 'Delete Account',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('1efbf140-0f5b-4cd2-8e98-f3b64981e10e', 'delete_credential', 'Delete Credential',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('dba8a67c-9401-4c84-8391-7caa21338abd', 'update_user_locale', 'Update User Locale',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('4cd2253c-1b3e-4d11-92df-3fd36b11fe64', 'webauthn-register', 'Webauthn Register',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('7de5f60f-10fc-4d89-8268-a4543f4d2c5f', 'webauthn-register-passwordless', 'Webauthn Register Passwordless',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('c8298878-d974-4a35-8687-9388f3e37687', 'VERIFY_PROFILE', 'Verify Profile',
        '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', true, false, 'VERIFY_PROFILE', 90);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('782e035c-59a3-48d0-8915-54ef48f5d706', 'VERIFY_EMAIL', 'Verify Email', '620962b5-3bd3-421b-a251-19eb7e5a870e',
        true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('9d6e01fc-25e7-4a39-88df-0b0794c33314', 'UPDATE_PROFILE', 'Update Profile',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('11980874-fbd9-41a9-a541-389e21e34df5', 'CONFIGURE_TOTP', 'Configure OTP',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('8fa79d16-7613-4076-b0c3-d14001a9108b', 'UPDATE_PASSWORD', 'Update Password',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('748799bd-400c-4ebf-ace8-ce2e767b61b1', 'TERMS_AND_CONDITIONS', 'Terms and Conditions',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', false, false, 'TERMS_AND_CONDITIONS', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('f5011d4e-dbb0-4873-9f42-27d78fe4151f', 'delete_account', 'Delete Account',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('cf7486c8-7c45-4791-8850-2187f1db3d48', 'delete_credential', 'Delete Credential',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'delete_credential', 100);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('94f64282-5aa7-4d9a-b0ab-492b83700494', 'update_user_locale', 'Update User Locale',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('c2f292d5-9cc8-4873-983a-5258209715de', 'webauthn-register', 'Webauthn Register',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'webauthn-register', 70);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('b85a8e26-c64b-44cf-9a9c-67b325cf037f', 'webauthn-register-passwordless', 'Webauthn Register Passwordless',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'webauthn-register-passwordless', 80);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority)
VALUES ('32e5e6cc-716c-4846-abb5-85c98e411fb9', 'VERIFY_PROFILE', 'Verify Profile',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', true, false, 'VERIFY_PROFILE', 90);


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scope_mapping (client_id, role_id)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', 'cd410a61-b616-4d96-8c38-08776a5c0e4c');
INSERT INTO public.scope_mapping (client_id, role_id)
VALUES ('09cb8fab-662c-42c1-b879-1c81cb5a239b', '10bb1a01-7e56-4e59-8c88-df3b6d140794');
INSERT INTO public.scope_mapping (client_id, role_id)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'd247c72f-013d-4a08-8aac-6b651ce7222c');
INSERT INTO public.scope_mapping (client_id, role_id)
VALUES ('31457512-e505-416e-8197-23868d87e0ae', 'dd6fd303-884c-4afd-a0cf-c9b462951d97');


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name,
                                last_name, realm_id, username, created_timestamp, service_account_client_link,
                                not_before)
VALUES ('58c00464-397d-4555-83fa-7297d73901db', NULL, 'dd2fc3dc-7b39-4230-ba26-8792bf887dad', false, true, NULL, NULL,
        NULL, '9439a8bc-d375-400d-8eb4-b43a1d70f0a4', 'admin', 1746374665086, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name,
                                last_name, realm_id, username, created_timestamp, service_account_client_link,
                                not_before)
VALUES ('595115b2-86d0-49e5-a2fe-ed67ffb7a713', NULL, '11abe061-a43c-4e74-b7a6-1ae15aa4b703', false, true, NULL, NULL,
        NULL, '620962b5-3bd3-421b-a251-19eb7e5a870e', 'service-account-dms-app', 1746398207686,
        'bcca3556-19ad-42e8-a0ca-48206ba498e8', 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name,
                                last_name, realm_id, username, created_timestamp, service_account_client_link,
                                not_before)
VALUES ('3c6348e8-bbf1-4371-a6f7-fbc7c045ac70', 'admin@dms', 'admin@dms', false, true, NULL, 'admin', 'admin',
        '620962b5-3bd3-421b-a251-19eb7e5a870e', 'admin', 1746374914268, NULL, 0);


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('3755f040-41d7-49e4-847b-ac896c124262', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('7ddaf178-5cff-4806-8f05-a6ed76551dc8', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('79d0b27e-b04e-4f8f-abbc-58c730a7ac18', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('f674c01d-4b2e-4446-8cc8-2503d615fddc', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('5fcf9430-8b9f-4503-a9bc-8636c7b19a30', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('62d2660c-b2c4-4243-a0ad-2ab2738873cb', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('f8b0b5d9-6a13-4959-9363-158db1816628', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('3f1ae63d-bdc9-4c76-a88d-09efb017c5c3', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('d3fee103-70ea-4f1b-a302-7e6c60d90be1', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('c4edd002-0e6d-450b-806c-6784a0022bed', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('4bdc51ef-eff6-4b7c-855b-c741f042b969', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('f306c0dc-4998-48c8-baef-ef9d51d4fa03', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('e1533655-40da-4f9b-961c-c337c9c4bd33', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('65cfa32e-f103-43ab-a0ac-db6e91c79091', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('e38ed989-0619-47a8-afaa-416920e40861', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('c2e878c1-013d-4d5e-bca9-22e0ea549a8d', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('cd17991a-c48e-43a5-8a89-2f25cb64e719', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('4fb31236-d941-473e-b1f6-99f12d61fcc8', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('c543883a-6aab-4ee7-86e4-b11937f30755', '58c00464-397d-4555-83fa-7297d73901db');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('338183bd-58a8-4e2b-8e16-ea21489bfd17', '3c6348e8-bbf1-4371-a6f7-fbc7c045ac70');
INSERT INTO public.user_role_mapping (role_id, user_id)
VALUES ('338183bd-58a8-4e2b-8e16-ea21489bfd17', '595115b2-86d0-49e5-a2fe-ed67ffb7a713');


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.web_origins (client_id, value)
VALUES ('0263cdd2-cf8a-41dc-940f-67b4665fefc8', '+');
INSERT INTO public.web_origins (client_id, value)
VALUES ('483f0d5a-9f54-42d5-933d-a3700a7c898f', '+');
INSERT INTO public.web_origins (client_id, value)
VALUES ('bcca3556-19ad-42e8-a0ca-48206ba498e8', '/*');


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider,
                                                           external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session (id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client (id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity (id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client (id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session (id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session (id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session (id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client (id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session (id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource (id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity (id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity (id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm (id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role (id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow (id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session (id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity (id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope (id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope (id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session (id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope (id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component (id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper (id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider (id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy (id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy (id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server (id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server (id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource (id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope (id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy (id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope (id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy (id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server (id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource (id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource (id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy (id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope (id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server (id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role (id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent (id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity (id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group (id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group (id);

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm (id);

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm (id);

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper (id);

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client (id);

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client (id);

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client (id);

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity (id);

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper (id);

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource (id);

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role (id);

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm (id);

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider (id);

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity (id);

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy (id);

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider (internal_id);

SELECT 'init.sql is executed'