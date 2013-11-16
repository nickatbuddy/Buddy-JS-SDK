﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BuddySDK
{

    [Flags]
    public enum BuddyClientFlags
    {
        AutoTrackLocation =  0x0000001,
        AutoRegisterDevice = 0x00000002,
        Default = AutoTrackLocation | AutoRegisterDevice
    }

    public static class Buddy
    {
        static BuddyClient _client;
        static Tuple<string, string, BuddyClientFlags> _creds;

        public static BuddyClient Instance
        {
            get
            {
                if (_creds == null)
                {
                    throw new InvalidOperationException("Init must be called before accessing Instance.");
                }
                if (_client == null)
                {
                    _client = new BuddyClient(_creds.Item1, _creds.Item2, null, _creds.Item3);
                }
                return _client;
            }
        }

        public static AuthenticatedUser CurrentUser
        {
            get
            {
                return Instance.User;
            }
        }

        public static void Init(string appId, string appKey, BuddyClientFlags flags = BuddyClientFlags.Default)
        {
            if (_creds != null)
            {
                throw new InvalidOperationException("Already initalized.");
            }
            _creds = new Tuple<string, string, BuddyClientFlags>(appId, appKey, flags);

        }

        public static Task<AuthenticatedUser> LoginUserAsync(string username, string password)
        {
            var t = Instance.LoginUserAsync(username, password);

            return t;
        }

        // 
        // Collections.
        //

        private static CheckinCollection _checkins;
        public static CheckinCollection Checkins
        {
            get
            {
                if (_checkins == null)
                {
                    _checkins = new CheckinCollection(Instance);
                }
                return _checkins;
            }
        }

        private static PhotoCollection _photos;

        public static PhotoCollection Photos
        {
            get
            {
                if (_photos == null)
                {
                    _photos = new PhotoCollection(Instance);
                }
                return _photos;
            }
        }

       
    }
}