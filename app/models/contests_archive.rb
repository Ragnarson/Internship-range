class ContestsArchive < Contest
  default_scope { where(active: false) }
end
