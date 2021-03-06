class Full::UserSerializer < UserSerializer
  attributes :email, :email_when_proposal_closing_soon, :email_missed_yesterday,
             :email_when_mentioned, :email_on_participation, :selected_locale, :locale,
             :default_membership_volume, :experiences, :is_coordinator

  has_many :formal_memberships, serializer: MembershipSerializer, root: :memberships
  has_many :guest_memberships,  serializer: Simple::MembershipSerializer, root: :memberships
  has_many :unread_threads,     serializer: DiscussionSerializer, root: :discussions
  has_many :notifications,      serializer: NotificationSerializer, root: :notifications
  has_many :identities,         serializer: IdentitySerializer, root: :identities

  def guest_memberships
    from_scope :memberships
  end

  def formal_memberships
    from_scope :formal_memberships
  end

  def unread_threads
    from_scope :unread
  end

  def notifications
    from_scope :notifications
  end

  def identities
    from_scope :identities
  end

  def is_coordinator
    object.adminable_group_ids.any?
  end

  def include_gravatar_md5?
    true
  end

  def include_has_password?
    true
  end

  private

  def from_scope(field)
    Array(Hash(scope)[field])
  end
end
